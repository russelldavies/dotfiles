# Dotfiles

My OS X or Debian/Ubuntu dotfiles.

Based on Ben Alman's [dotfiles](https://github.com/cowboy/dotfiles)

[dotfiles]: https://github.com/russelldavies/dotfiles/blob/master/bin/dotfiles
[bin]: https://github.com/russelldavies/dotfiles/tree/master/bin

## Usage

There is a bash script [dotfiles][dotfiles] which when run does a few things:

1. Git is installed if necessary, via APT or Homebrew (which is installed if necessary).
1. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
1. Files in `copy` are copied into `~/`.
1. Files in `link` are linked into `~/`.
1. Files in `init` are executed (in alphanumeric order).

Note:

* Subsequently running [dotfiles][dotfiles] reinitializes the dotfiles.
* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executables ([~/.dotfiles/bin][bin] is added into the path).
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## Installation
### OS X
Notes:

* You need to be an administrator (for `sudo`).
* You need to have installed [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a separate, optional (and _much smaller_) download from XCode.

```sh
bash -c "$(curl -fsSL https://raw.github.com/russelldavies/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

### Debian/Ubuntu
Notes:

* You need to be an administrator (for `sudo`).
* If APT hasn't been updated or upgraded recently, it will probably be a few minutes before you see anything.

```sh
sudo apt-get -qq update && sudo apt-get -qq upgrade && sudo apt-get -qq install curl && echo &&
bash -c "$(curl -fsSL https://raw.github.com/russelldavies/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## The "init" step
Installs specified packages depending on the OS and updates other software such as vim bundles.

## License
Copyright (c) 2012 "Cowboy" Ben Alman  
Licensed under the MIT license.  
<http://benalman.com/about/license/>
