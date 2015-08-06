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

I've included what I think is a good starter set of zsh plugins in this repository. To make the list easier to customize, if you create a file named `~/.zgen-local-plugins`, the starter kit will source that **instead** of running `load-starter-plugin-list` as defined in `.zgen-setup`. I`~/.zgen-local-plugins` is not additive, it completely replaces the kit-provided list.

# Other Resources

## ZSH

For a list of other ZSH plugins and themes you can use, check out my [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins) list.

## Vim

If you're using vim, [spf13](http://vim.spf13.com/) is an excellent starter configuration and plugin collection.
