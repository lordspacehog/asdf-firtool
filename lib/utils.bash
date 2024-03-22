#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/llvm/circt"
TOOL_NAME="firtool"
TOOL_TEST="firtool --version"

VERSION_QUIRKS=(
	"1.26.0"
	"1.27.0"
	"1.28.0"
	"1.29.0"
	"1.30.0"
	"1.31.0"
	"1.32.0"
	"1.33.0"
	"1.34.0"
	"1.34.1"
	"1.34.2"
	"1.34.3"
	"1.34.4"
	"1.35.0"
	"1.36.0"
	"1.37.0"
	"1.37.1"
	"1.38.0"
	"1.39.0"
	"1.40.0"
	"1.41.0"
	"1.42.0"
	"1.43.0"
	"1.44.0"
)

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/firtool-.*' | cut -d/ -f3- |
		sed 's/^firtool-//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url_base asset_filename
	version="$1"
	filename="$2"

	url_base="$GH_REPO/releases/download/firtool-${version}"

	if [[ ${VERSION_QUIRKS[*]} =~ $version ]]; then
		case "$version" in
		1.4[0-4].0 | 1.37.[12])
			asset_filename="firrtl-bin-ubuntu-20.04.tar.gz"
			;;
		*)
			asset_filename="circt-bin-ubuntu-20.04.tar.gz"
			;;
		esac
	else
		asset_filename="firrtl-bin-linux-x64.tar.gz"
	fi

	url="${url_base}/${asset_filename}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"

		cp "$ASDF_DOWNLOAD_PATH"/firtool "$install_path"
		chmod +x "${install_path}/firtool"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
