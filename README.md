# asdf-firtool


[![Build](https://github.com/lordspacehog/asdf-firtool/actions/workflows/build.yml/badge.svg)](https://github.com/lordspacehog/asdf-firtool/actions/workflows/build.yml) [![Lint](https://github.com/lordspacehog/asdf-firtool/actions/workflows/lint.yml/badge.svg)](https://github.com/lordspacehog/asdf-firtool/actions/workflows/lint.yml)

[firtool](https://circt.llvm.org/docs/) plugin for the [asdf version manager](https://asdf-vm.com).

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add firtool
# or
asdf plugin add firtool https://github.com/lordspacehog/asdf-firtool.git
```

firtool:

```shell
# Show all installable versions
asdf list-all firtool

# Install specific version
asdf install firtool latest

# Set a version globally (on your ~/.tool-versions file)
asdf global firtool latest

# Now firtool commands are available
firtool --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/lordspacehog/asdf-firtool/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Alex Swehla](https://github.com/lordspacehog/)
