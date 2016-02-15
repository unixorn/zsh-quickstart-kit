# ZSH Quickstart Kit
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation](#installation)
  - [Prerequisites](#prerequisites)
    - [Fonts](#fonts)
    - [OS X](#os-x)
    - [Linux](#linux)
  - [Set up Zgen and the starter kit](#set-up-zgen-and-the-starter-kit)
  - [Customizations](#customizations)
    - [Functions and Aliases](#functions-and-aliases)
    - [zgen plugin list](#zgen-plugin-list)
    - [Included plugins:](#included-plugins)
- [Other Resources](#other-resources)
  - [ZSH](#zsh)
  - [Dotfiles in general](#dotfiles-in-general)
  - [Vim](#vim)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Installation

## Prerequisites

### Fonts

This quickstart includes a prompt theme that requires a powerline-compatible font in your terminal. Fonts that are powerline-compatible include glyphs used to display the nice branch icon that the theme in this `.zshrc` uses, among other useful glyphs. Here are a few good powerline fonts I've found:

* [Awesome Terminal Fonts ![GitHub stars](https://img.shields.io/github/stars/gabrielelana/awesome-terminal-fonts.svg)](https://github.com/gabrielelana/awesome-terminal-fonts) - A family of fonts that includes some nice monospaced Icons.
* [Fantasque Awesome Font ![GitHub stars](https://img.shields.io/github/stars/ztomer/fantasque_awesome_powerline.svg)](https://github.com/ztomer/fantasque_awesome_powerline) - A nice monospaced font, patched with Font-Awesome, Octoicons and Powerline-Glyphs.
* [Hack](http://sourcefoundry.org/hack/) - Another Powerline-compatible font designed specifically for source code and terminal usage.
* [Input Mono](http://input.fontbureau.com/) - A family of fonts designed specifically for code. It offers both monospaced and proportional fonts and includes powerline glyphs.
* [Monoid](http://larsenwork.com/monoid/) - Monoid is customizable and optimized for coding with bitmap-like sharpness at 15px line-height even on low res displays.
* [Nerd fonts ![GitHub stars](https://img.shields.io/github/stars/ryanoasis/nerd-fonts.svg)](https://github.com/ryanoasis/nerd-fonts) - A collection of over 20 patched fonts (over 1,700 variations) & fontforge font patcher python script for powerline, devicons, and vim-devicons: includes Droid Sans, Meslo, AnonymousPro, ProFont, Inconsolta, and many more.
* [Powerline patched font collection ![GitHub stars](https://img.shields.io/github/stars/powerline/fonts.svg)](https://github.com/powerline/fonts) - A collection of a dozen or so fonts patched to include powerline gylphs.

### OS X

1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com). It is considerably nicer than the stock Terminal application that comes with OS X.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. Install GNU Stow with `brew install stow`
4. Homebrew has a newer version of zsh than the one Apple ships, so `brew install zsh` to install it.
5. Switch your shell to zsh
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    4. Select advanced options
    5. Set your login shell to `/bin/zsh` (or `/usr/local/bin/zsh` if you decided to use the newer version packaged by brew)
6. Install some powerline compatible fonts from one of the links in the Fonts section above.
    1. Install a powerline-compatible font from the Fonts section above.
    2. In iTerm 2, go to Preferences->Profile in your iTerm 2 preferences, then select one of the powerline compatible fonts you just installed.
    3. **Make sure you also specify a powerline compatible font for non-ASCII in your iTerm 2 preferences or the prompt separators and branch glyphs will show up garbled**.

### Linux

1. Switch your shell to zsh with `chsh -s /bin/zsh`
2. Install GNU Stow - `yum install -y stow` on Red Hat / CentOS systems

I don't use a GUI on Linux, so you'll have to track down how to install new fonts, then install one of the powerline fonts and specify it for your terminal application. If you get garbled branch glyphs, make sure there isn't a separate font setting for non-ASCII characters that you need to also set to your chosen powerline font.

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
* Cross-session shared history
* Deduping your command history
* Many more tab completions, courtesy of the [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) repository, and periodic updating to tip of master of that repository.
* Proper command history search
* Syntax highlighting at the command line
* Tab completion of Rakefile targets
* Using oh-my-zsh compatible plugins and themes (via the [zgen](https://github.com/tarjoilija/zgen) framework)
* Various helper functions for interacting with OS X's clipboard, audio volume, Spotlight and Quicklook.

## Customizations

### Functions and Aliases

The `.zshrc` included in this kit will automatically source any files it finds in `~/.zshrc.d`. This is to make it easy for you to add extra functions and aliases without having to maintain a separate fork of this repository. The files will be sourced in alphanumeric order, I suggest a naming scheme of `001-onething`, `002-something-else` etc to ensure they're loaded in the order you expect.

### zgen plugin list

I've included what I think is a good starter set of zsh plugins in this repository. To make the list easier to customize without having to maintain a separate fork of this kit, if you create a file named `~/.zgen-local-plugins`, the `.zshrc` from this starter kit will source that **instead** of running the `load-starter-plugin-list` function defined in `~/.zgen-setup`. **Note: using `~/.zgen-local-plugins` is not additive, it will completely replace the kit-provided list.**

### Included plugins:

* [RobSis/zsh-completion-generator](https://github.com/RobSis/zsh-completion-generator) - Adds tool to generate zsh completion functions for programs missing them
* [chrissicool/zsh-256color](https://github.com/chrissicool/zsh-256color) - sets your terminal to 256 colors if available
* [djui/alias-tips](https://github.com/djui/alias-tips) - Warns you when you have an alias for the command you just typed, and tells you what it is
* [peterhurford/git-it-on.zsh](https://github.com/peterhurford/git-it-on.zsh) - Opens your current repo on github, in your current branch
* [rimraf/k](https://github.com/rimraf/k) - k is a directory lister that also shows git status on files & directories
* [sharat87/pip-app](https://github.com/sharat87/pip-app) - A set of shell functions to make it easy to install small apps and utilities distributed with pip
* [skx/sysadmin-util](https://github.com/skx/sysadmin-util) - A collection of scripts useful for sysadmins
* [srijanshetty/docker-zsh](https://github.com/srijanshetty/docker-zsh) - Docker completions
* [stackexchange/blackbox](https://github.com/stackexchange/blackbox) - Tom Limoncelli's tool for storing secret information in a repository with gnupg encryption, automatically decrypting as needed
* [unixorn/autoupdate-zgen](https://github.com/unixorn/autoupdate-zgen) - Adds autoupdate (for both zgen itself, and your plugins) to zgen
* [unixorn/git-extra-commands](https://github.com/unixorn/git-extra-commands) - Collected extra git helper scripts
* [unixorn/jpb.zshplugin](https://github.com/unixorn/jpb.zshplugin) - Some of my standard aliases & functions
* [unixorn/rake-completion.zshplugin](https://github.com/unixorn/rake-completion.zshplugin) - Reads your Rakefile to tab complete the Rakefile targets
* [unixorn/tumult.plugin.zsh](https://github.com/unixorn/tumult.plugin.zsh) - OSX specific functions and scripts.
* [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - Better history search
* [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Syntax highlighting as you type
* [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) - Tab completions for many more applications than come standard with zsh

We also have zgen load oh-my-zsh and these plugins:
* oh-my-zsh
    * aws
    * brew
    * chruby
    * colored-man
    * git
    * github
    * osx
    * pip
    * python
    * rsync
    * screen
    * sudo
    * vagrant

# Other Resources

## ZSH

For a list of other ZSH plugins and themes you can use, check out my [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins) list.

## Dotfiles in general

[dotfiles.github.io/](https://dotfiles.github.io/) has a lot of great resources for dotfiles - frameworks for managing them, configurations for editors and bootstraps with initial configurations to start from.

## Vim

If you're using vim, [spf13](http://vim.spf13.com/) is an excellent starter configuration and plugin collection.
