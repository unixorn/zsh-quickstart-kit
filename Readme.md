# ZSH Quickstart Kit

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://travis-ci.org/unixorn/zsh-quickstart-kit.svg?branch=master)](https://travis-ci.org/unixorn/zsh-quickstart-kit)
[![Code Climate](https://codeclimate.com/github/unixorn/zsh-quickstart-kit/badges/gpa.svg)](https://codeclimate.com/github/unixorn/zsh-quickstart-kit)
[![GitHub stars](https://img.shields.io/github/stars/unixorn/zsh-quickstart-kit.svg)](https://github.com/unixorn/zsh-quickstart-kit/stargazers)
[![Issue Count](https://codeclimate.com/github/unixorn/zsh-quickstart-kit/badges/issue_count.svg)](https://codeclimate.com/github/unixorn/zsh-quickstart-kit)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation](#installation)
  - [Prerequisites](#prerequisites)
    - [Fonts](#fonts)
  - [OS Setup](#os-setup)
    - [macOS](#macos)
    - [Linux](#linux)
  - [Set up Zgen and the starter kit](#set-up-zgen-and-the-starter-kit)
  - [Customizations](#customizations)
    - [Functions and Aliases](#functions-and-aliases)
    - [Self-update Settings](#self-update-settings)
    - [Changing the zgen plugin list](#changing-the-zgen-plugin-list)
    - [Included plugins:](#included-plugins)
- [Other Resources](#other-resources)
  - [ZSH](#zsh)
  - [Dotfiles in general](#dotfiles-in-general)
  - [Vim](#vim)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Installation

## Prerequisites

### Fonts

This quickstart includes the [bullet-train](https://github.com/caiogondim/bullet-train.zsh) zsh theme, which requires a powerline-compatible font in your terminal to display certain status glyphs. Fonts that are powerline-compatible include glyphs used to display the nice branch icon that the theme in this `.zshrc` uses, among other useful glyphs.

Here are a few good powerline-compatible fonts I've found:

* [Awesome Terminal Fonts](https://github.com/gabrielelana/awesome-terminal-fonts) - A family of fonts that includes some nice monospaced Icons.
* [Fantasque Awesome Font](https://github.com/ztomer/fantasque_awesome_powerline) - A nice monospaced font, patched with Font-Awesome, Octoicons and Powerline-Glyphs.
* [Fira Mono](https://github.com/mozilla/Fira) - Mozilla's Fira type family.
* [Hack](http://sourcefoundry.org/hack/) - Another Powerline-compatible font designed specifically for source code and terminal usage.
* [Input Mono](http://input.fontbureau.com/) - A family of fonts designed specifically for code. It offers both monospaced and proportional fonts and includes powerline glyphs.
* [Iosevka](https://be5invis.github.io/Iosevka/) - Iosevka is an open source slender monospace sans-serif and slab-serif typeface inspired by [Pragmata Pro](http://www.fsd.it/fonts/pragmatapro.htm), [M+](http://mplus-fonts.osdn.jp/) and [PF DIN Mono](http://www.parachute.gr/typefaces/allfonts/din-mono-pro), designed to be the ideal font for programming.
* [Monoid](http://larsenwork.com/monoid/) - Monoid is customizable and optimized for coding with bitmap-like sharpness at 15px line-height even on low res displays.
* [Mononoki](https://madmalik.github.io/mononoki/) - Mononoki is a typeface by Matthias Tellen, created to enhance code formatting.
* [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) - A collection of over 20 patched fonts (over 1,700 variations) & fontforge font patcher python script for powerline, devicons, and vim-devicons: includes Droid Sans, Meslo, AnonymousPro, ProFont, Inconsolta, and many more.
* [Powerline patched font collection](https://github.com/powerline/fonts) - A collection of a dozen or so fonts patched to include powerline gylphs.
* [spacemono](https://github.com/googlefonts/spacemono) - Google's new original monospace display typeface family.

## OS-specific setup

### macOS

1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com). It is considerably nicer than the stock Terminal application that comes with macOS.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. Install GNU Stow with `brew install stow`
4. Homebrew has a newer version of zsh than the one Apple ships, so `brew install zsh` to install it.
5. Switch your shell to zsh:
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    4. Select advanced options
    5. Set your login shell to `/bin/zsh` (or `/usr/local/bin/zsh` if you decided to use the newer version packaged by brew)
6. Install some powerline compatible fonts from one of the links in the Fonts section above.
    1. In iTerm 2, go to Preferences->Profile in your iTerm 2 preferences, then select one of the powerline compatible fonts you just installed.
    2. **Make sure you also specify a powerline compatible font for non-ASCII in your iTerm 2 preferences or the prompt separators and branch glyphs will show up garbled**.

### Linux

1. Switch your shell to zsh with `chsh -s /bin/zsh`
2. Install GNU Stow - `yum install -y stow` on Red Hat / CentOS systems, `apt-get -y install stow` on Debian / Ubuntu.
3. Install the patched font in a valid X font path. Valid font paths can be listed with `xset q`: `mv YourChosenPowerlineFont.otf ~/.fonts`
4. Update the font cache for the path the font was installed in (root privileges may be needed for updating font cache for some paths): `fc-cache -vf ~/.fonts/`

After installing a powerline-compatible font, you will also need to configure your terminal emulator to use your selected powerline-compatible font. The name of the correct font usually ends with *for Powerline*.

If the powerline symbols cannot be seen, try closing all instances of the terminal emulator. The X server may also need to be restarted for the new font to correctly load.

If you still can’t see the powerline fonts then double-check that the font has been installed to a valid X font path.

If you get garbled branch glyphs, make sure there isn't a separate font setting for non-ASCII characters in your terminal application that you also need to set to use a powerline-compatible font. Konsole needs to be set to use UTF-8 encoding, for example.

## Set up Zgen and the starter kit

Now that your fonts and default shell have been set up, install [zgen](https://github.com/tarjoilija/zgen) and the dotfiles from this starter kit repository.

1. Install [Zgen](https://github.com/tarjoilija/zgen)
    1. `cd ~`
    2. `git clone git@github.com:tarjoilija/zgen.git`
2. Install the starter kit
    1. `cd ~`
    2. `git clone git@github.com:unixorn/zsh-quickstart-kit.git`
3. Configure zsh by symlinking the `.zshrc`, `.zsh_aliases` and `.zsh-completions` from this repo into your `~`.
    1. You can do this with stow by:
        1. `cd zsh-quickstart-kit`
        2. `stow --target=/Users/YourUsername zsh`. Replace `/Users/YourUsername` with `/home/YourUsername` if you're on Linux.

The `.zshrc`, `.zsh_aliases` & `.zsh_functions` files included in this kit enable:

* Automatic periodic updates to zgen and your plugins
* Cross-session shared history so commands typed in one terminal window can be seen and searched in all other windows on the same machine.
* Deduping your command history
* Many more tab completions, courtesy of the [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) repository, and periodic updating to tip of master of that repository so you get new completions and updates of old ones.
* Proper command history search
* Syntax highlighting at the command line
* Tab completion of Rakefile targets
* Using oh-my-zsh compatible plugins and themes (via the [zgen](https://github.com/tarjoilija/zgen) framework)
* Various helper functions for interacting with macOS's clipboard, audio volume, Spotlight and Quicklook.

## Customizations

### Functions and Aliases

The `.zshrc` included in this kit will automatically source any files it finds in `~/.zshrc.d`. This is to make it easy for you to add extra functions and aliases without having to maintain a separate fork of this repository. The files will be sourced in alphanumeric order, I suggest you use a naming scheme of `001-onething`, `002-something-else` etc to ensure they're loaded in the order you expect.

### Self-update Settings

The quickstart kit will check for updates every seven days. If you want to change the interval, set `QUICKSTART_KIT_REFRESH_IN_DAYS` in a file in `~/.zshrc.d`. If you want to disable self updating entirely, add `unset QUICKSTART_KIT_REFRESH_IN_DAYS` in a file in `~/.zshrc.d`.

### Changing the zgen plugin list

I've included what I think is a good starter set of zsh plugins in this repository. However, everyone has their own preferences for their environment, so to make the list easier to customize without having to maintain a separate fork of this kit, if you create a file named `~/.zgen-local-plugins`, the `.zshrc` from this starter kit will source that **instead** of running the `load-starter-plugin-list` function defined in `~/.zgen-setup`.

**Note: using `~/.zgen-local-plugins` is not additive, it will completely replace the kit-provided list.**

I'm told it's a pain to have to create `.zgen-local-plugins` from scratch, so to make customizing the plugins easier, I've included a `.zgen-local-plugins-example` file at the root of the repository that will install the same plugins that the kit does by default for you to use as a starting point for your own customizations.

Copy that to your `$HOME`, change the list and the next time you start a terminal session you'll get your list instead of mine.

### Included plugins:

* [chrissicool/zsh-256color](https://github.com/chrissicool/zsh-256color) - Sets your terminal to 256 colors if available.
* [djui/alias-tips](https://github.com/djui/alias-tips) - Warns you when you have an alias for the command you just typed, and tells you what it is.
* [peterhurford/git-it-on.zsh](https://github.com/peterhurford/git-it-on.zsh) - Opens your current repo on github, in your current branch.
* [supercrabtree/k](https://github.com/supercrabtree/k) - k is a directory lister that also shows git status on files & directories.
* [RobSis/zsh-completion-generator](https://github.com/RobSis/zsh-completion-generator) - Adds a tool to generate zsh completion functions for programs missing them by parsing their `--help` output. Note that this doesn't happen dynamically, you'll have to explicitly create a completion for each command you need one for.
* [sharat87/pip-app](https://github.com/sharat87/pip-app) - A set of shell functions to make it easy to install small apps and utilities distributed with pip.
* [skx/sysadmin-util](https://github.com/skx/sysadmin-util) - A collection of scripts useful for sysadmins.
* [srijanshetty/docker-zsh](https://github.com/srijanshetty/docker-zsh) - Docker completions.
* [stackexchange/blackbox](https://github.com/stackexchange/blackbox) - Tom Limoncelli's tool for storing secret information in a repository with gnupg encryption, automatically decrypting as needed.
* [unixorn/autoupdate-zgen](https://github.com/unixorn/autoupdate-zgen) - Adds autoupdate (for both zgen itself, and your plugins) to zgen.
* [unixorn/bitbucket-git-helpers](https://github.com/unixorn/bitbucket-git-helpers.plugin.zsh) - Adds git helper scripts for bitbucket.
* [unixorn/git-extra-commands](https://github.com/unixorn/git-extra-commands) - Collected extra git helper scripts.
* [unixorn/jpb.zshplugin](https://github.com/unixorn/jpb.zshplugin) - Some of my standard aliases & functions.
* [unixorn/rake-completion.zshplugin](https://github.com/unixorn/rake-completion.zshplugin) - Reads your Rakefile to tab complete the Rakefile targets.
* [unixorn/tumult.plugin.zsh](https://github.com/unixorn/tumult.plugin.zsh) - Adds macOS-specific functions and scripts. This plugin only adds itself to your `$PATH` if you're on macOS.
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Adds fish-like autosuggestions to your zsh sessions.
* [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) - Tab completions for many more applications than come standard with zsh.
* [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - Better history search.
* [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Syntax highlighting as you type.

The quickstart kit uses zgen to load oh-my-zsh and these plugins:
  * aws
  * brew - only loaded on macOS
  * chruby
  * colored-man
  * git
  * github
  * osx - only loaded on macOS
  * pip
  * python
  * rsync
  * screen
  * sudo
  * vagrant

# Other Resources

## ZSH

For a list of other ZSH plugins and themes you might like to use, check out my [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins) list.

## Dotfiles in general

[dotfiles.github.io/](https://dotfiles.github.io/) has a lot of great resources for dotfiles - frameworks for managing them, configurations for editors and bootstraps with initial configurations to start from.

## Vim

If you're using vim, [spf13](http://vim.spf13.com/) is an excellent starter configuration and plugin collection.
