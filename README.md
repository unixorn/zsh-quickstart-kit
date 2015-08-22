# ZSH Quickstart Kit
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation](#installation)
  - [Prerequisites](#prerequisites)
    - [OS X](#os-x)
    - [Linux](#linux)
  - [Set up Zgen and the starter kit](#set-up-zgen-and-the-starter-kit)
  - [Customizations](#customizations)
    - [Functions and Aliases](#functions-and-aliases)
    - [zgen plugin list](#zgen-plugin-list)
- [Other Resources](#other-resources)
  - [ZSH](#zsh)
  - [Vim](#vim)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Installation

## Prerequisites

### OS X

1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com). Seriously, never use Terminal again.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. `brew install stow`
4. Homebrew has a newer version of zsh than the one Apple ships, so `brew install zsh` to install it.
5. Switch your shell to zsh
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    4. Select advanced options
    5. Set your login shell to `/bin/zsh` (`/usr/local/bin/zsh` if you decided to use a newer version from brew)
6. Install some powerline compatible fonts from [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts) or [Input Mono](http://input.fontbureau.com/). Fonts that are Powerline-compatible include glyphs used to display the nice branch icon that the theme in this `.zshrc` uses.
    1. Clone the [powerline-fonts](https://github.com/Lokaltog/powerline-fonts) repository, or download [Input Mono](http://input.fontbureau.com/).
    2. Copy the fonts into `~/Library/Fonts`.
    3. In iTerm 2, go to Preferences->Profile in your iTerm 2 preferences, then select one of the powerline compatible fonts you just installed.
    4.  Make sure you also specify a powerline compatible font for non-ASCII in your iTerm 2 preferences or the prompt separators and branch glyphs will show up garbled.

### Linux

1. Switch your shell to zsh with chsh `chsh -s /bin/zsh`
2. Install GNU Stow - `yum install -y stow` on Red Hat / CentOS systems

I don't use a GUI on Linux, so you'll have to track down how to install the [powerline-fonts](https://github.com/Lokaltog/powerline-fonts) and specify one for your terminal application.

## Set up Zgen and the starter kit

Now that your fonts and default shell have been set up, install [zgen](https://github.com/tarjoilija/zgen) and the starter kit dotfiles.

1. Install [Zgen](https://github.com/tarjoilija/zgen)
    1. `cd ~`
    2. `git clone git@github.com:tarjoilija/zgen.git`
2. Install the starter kit
    1. `cd ~`
    2. `git clone git@github.com:unixorn/zsh-starter-kit.git`
2. Configure zsh by symlinking the `.zshrc`, `.zsh_aliases` and `.zsh-completions` from this repo into your `~`. You can do this with stow by running `stow --target=/Users/YourUsername zsh` in the top level of this repository. Replace `/Users/YourUsername` with `/home/YourUsername` if you're on Linux.

The included `.zshrc`, `.zsh_aliases` & `.zsh_functions` files enable:

* Automatic periodic install and update of zgen and your plugins
* Cross-session shared history
* Deduping your command history
* Many more tab completions, courtesy of the [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) repository
* Proper command history search
* Syntax highlighting at the command line
* Tab completion of Rakefile targets
* Various helper functions for interacting with OS X's clipboard, audio volume, and Quicklook.
* oh-my-zsh compatible plugins and themes (via the [zgen](https://github.com/tarjoilija/zgen) framework)

## Customizations

### Functions and Aliases

The `.zshrc` included in this kit will automatically source any files it finds in `~/.zshrc.d`. This makes it easy for you to add extra functions and aliases without having to maintain a separate branch of this repo. The files will be sourced in alphanumeric order, I suggest a naming scheme of `001-onething`, `002-something-else` to ensure they're loaded in the order you expect.

### zgen plugin list

I've included what I think is a good starter set of zsh plugins in this repository. To make the list easier to customize, if you create a file named `~/.zgen-local-plugins`, the starter kit will source that **instead** of running `load-starter-plugin-list` as defined in `.zgen-setup`. Note: `~/.zgen-local-plugins` is not additive, it completely replaces the kit-provided list.

Included plugins:
* [RobSis/zsh-completion-generator](https://github.com/RobSis/zsh-completion-generator) - Adds tool to generate zsh completion functions for programs missing them
* [chrissicool/zsh-256color](https://github.com/chrissicool/zsh-256color) - sets your terminal to 256 colors if available
* [djui/alias-tips](https://github.com/djui/alias-tips) - Warns you when you have an alias for the command you just typed
* [peterhurford/git-it-on.zsh](https://github.com/peterhurford/git-it-on.zsh) - Opens your current repo on github, in your current branch
* [rimraf/k](https://github.com/rimraf/k) - k is a directory lister that also shows git status on files & directories
* [sharat87/pip-app](https://github.com/sharat87/pip-app) - A set of shell functions to make it easy to install small apps and utilities distributed with pip
* [skx/sysadmin-util](https://github.com/skx/sysadmin-util) - Collected scripts useful for sysadmins
* [srijanshetty/docker-zsh](https://github.com/srijanshetty/docker-zsh) - Docker completions
* [stackexchange/blackbox](https://github.com/stackexchange/blackbox) - Tom Limoncelli's tool for storing secret information in a repository with gnupg encryption, automatically decrypting as needed
* [unixorn/autoupdate-zgen](https://github.com/unixorn/autoupdate-zgen) - Adds autoupdate (for both zgen itself, and your plugins) to zgen
* [unixorn/git-extra-commands](https://github.com/unixorn/git-extra-commands) - Collected extra git helper scripts
* [unixorn/jpb.zshplugin](https://github.com/unixorn/jpb.zshplugin) - Some of my standard aliases & functions
* [unixorn/rake-completion.zshplugin](https://github.com/unixorn/rake-completion.zshplugin) - Tab completion for Rakefile targets
* [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - Better history search
* [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Syntax highlighting as you type

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

## Vim

If you're using vim, [spf13](http://vim.spf13.com/) is an excellent starter configuration and plugin collection.
