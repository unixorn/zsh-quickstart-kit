# ZSH Quickstart Kit

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Funixorn%2Fzsh-quickstart-kit%2Fbadge&style=plastic)](https://actions-badge.atrox.dev/unixorn/zsh-quickstart-kit/goto)
![Awesomebot](https://github.com/unixorn/zsh-quickstart-kit/actions/workflows/awesomebot.yml/badge.svg)
![Megalinter](https://github.com/unixorn/zsh-quickstart-kit/actions/workflows/mega-linter.yml/badge.svg)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/unixorn/zsh-quickstart-kit/main.svg)](https://github.com/unixorn/zsh-quickstart-kit)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Announcement](#announcement)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
    - [Fonts](#fonts)
  - [OS-specific setup](#os-specific-setup)
    - [fzf](#fzf)
    - [macOS](#macos)
    - [Linux](#linux)
  - [Set up Zgenom and the starter kit](#set-up-zgenom-and-the-starter-kit)
- [Contents of the kit](#contents-of-the-kit)
  - [Included plugins](#included-plugins)
- [Customizing the kit](#customizing-the-kit)
  - [Behavior toggles](#behavior-toggles)
    - [zqs](#zqs)
      - [zqs check-for-updates](#zqs-check-for-updates)
      - [zqs-disable-bindkey-handling](#zqs-disable-bindkey-handling)
      - [zqs-enable-bindkey-handling](#zqs-enable-bindkey-handling)
      - [zqs disable-omz-plugins](#zqs-disable-omz-plugins)
      - [zqs enable-control-c-decorator](#zqs-enable-control-c-decorator)
      - [zqs disable-control-c-decorator](#zqs-disable-control-c-decorator)
      - [zqs enable-omz-plugins](#zqs-enable-omz-plugins)
      - [zqs enable-ssh-askpass-require](#zqs-enable-ssh-askpass-require)
      - [zqs disable-ssh-askpass-require](#zqs-disable-ssh-askpass-require)
      - [zqs-disable-ssh-key-listing](#zqs-disable-ssh-key-listing)
      - [zqs-enable-ssh-key-listing](#zqs-enable-ssh-key-listing)
      - [zqs-disable-ssh-key-loading](#zqs-disable-ssh-key-loading)
      - [zqs-enable-ssh-key-loading](#zqs-enable-ssh-key-loading)
      - [zqs-disable-zmv-autoloading](#zqs-disable-zmv-autoloading)
      - [zqs-enable-zmv-autoloading](#zqs-enable-zmv-autoloading)
      - [zqs selfupdate](#zqs-selfupdate)
      - [zqs update](#zqs-update)
      - [zqs update-plugins](#zqs-update-plugins)
      - [zqs cleanup](#zqs-cleanup)
      - [zqs get-setting](#zqs-get-setting)
      - [zqs set-setting](#zqs-set-setting)
      - [zqs delete-setting](#zqs-delete-setting)
  - [Functions and Aliases](#functions-and-aliases)
    - [Customizing with ~/.zshrc.d](#customizing-with-zshrcd)
  - [I like a plugin, but some of the aliases and functions it installs overwrite other commands or aliases I use](#i-like-a-plugin-but-some-of-the-aliases-and-functions-it-installs-overwrite-other-commands-or-aliases-i-use)
  - [ZSH options](#zsh-options)
    - [Fragment file directories](#fragment-file-directories)
  - [Self-update Settings](#self-update-settings)
  - [Customizing the plugin list](#customizing-the-plugin-list)
    - [Using fragment files](#using-fragment-files)
    - [Complete plugin list replacement](#complete-plugin-list-replacement)
  - [Disabling zmv](#disabling-zmv)
  - [Disabling oh-my-zsh](#disabling-oh-my-zsh)
- [FAQ](#faq)
  - [How do I reconfigure the prompt?](#how-do-i-reconfigure-the-prompt)
  - [Powerlevel 10k warns that there is console output during startup](#powerlevel-10k-warns-that-there-is-console-output-during-startup)
  - [I added a new completion plugin, and it isn't working](#i-added-a-new-completion-plugin-and-it-isnt-working)
  - [I get a git error when I try to update the kit](#i-get-a-git-error-when-i-try-to-update-the-kit)
  - [GNU stow is warning that stowing zsh would cause conflicts](#gnu-stow-is-warning-that-stowing-zsh-would-cause-conflicts)
  - [_arguments:comparguments:325: can only be called from completion function](#_argumentscomparguments325-can-only-be-called-from-completion-function)
  - [Could not open a connection to your authentication agent](#could-not-open-a-connection-to-your-authentication-agent)
  - [I want to pin a plugin version](#i-want-to-pin-a-plugin-version)
- [Other Resources](#other-resources)
  - [ZSH](#zsh)
  - [Dotfiles in general](#dotfiles-in-general)
  - [Vim](#vim)
- [Thanks](#thanks)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Announcement

I've switched the quickstart kit to use [zgenom](https://github.com/jandamm/zgenom.git) instead of `zgen`. This should be a painless update since `zgenom` is a superset of `zgen`.
## Installation

### Prerequisites

#### Fonts

This quickstart includes the [powerlevel10k](https://github.com/romkatv/powerlevel10k) ZSH theme, which requires a Powerline-compatible font in your terminal to display status glyphs. Powerline-compatible fonts include many useful glyphs, including the nice branch icon that the theme in this `.zshrc` uses.

Here are a few good Powerline-compatible fonts:

* [Awesome Terminal Fonts](https://github.com/gabrielelana/awesome-terminal-fonts) - A family of fonts that include some nice monospaced Icons.
* [Cascadia Code](https://github.com/microsoft/cascadia-code) - Microsoft's Cascadia Code
* [Fantasque Awesome Font](https://github.com/ztomer/fantasque_awesome_powerline) - A nice monospaced font, patched with Font-Awesome, Octoicons, and Powerline-Glyphs.
* [Fira Mono](https://github.com/mozilla/Fira) - Mozilla's Fira type family.
* [Hack](http://sourcefoundry.org/hack/) - Another Powerline-compatible font designed for source code and terminal usage.
* [Input Mono](https://input.djr.com/) - A family of fonts designed specifically for code. It offers both monospaced and proportional fonts and includes Powerline glyphs.
* [Iosevka](https://be5invis.github.io/Iosevka/) - Iosevka is an open source slender monospace sans-serif and slab-serif typeface inspired by [Pragmata Pro](http://www.fsd.it/fonts/pragmatapro.htm), M+ and [PF DIN Mono](https://www.myfonts.com/fonts/parachute/pf-din-mono/), designed to be the ideal font for programming.
* [Monoid](http://larsenwork.com/monoid/) - Monoid is customizable and optimized for coding with bitmap-like sharpness at 15px line-height even on low res displays.
* [Mononoki](https://madmalik.github.io/mononoki/) - Mononoki is a typeface by Matthias Tellen, created to enhance code formatting.
* [More Nerd Fonts](https://www.nerdfonts.com/font-downloads) - Another site to download nerd fonts.
* [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) - A collection of over 20 patched fonts (over 1,700 variations) & the fontforge font patcher python script for Powerline, devicons, and vim-devicons: includes Droid Sans, Meslo, AnonymousPro, ProFont, Inconsolta, and many more. These can be installed with `brew` - do `brew tap homebrew/cask-fonts && brew install --cask fontname`
* [Powerline patched font collection](https://github.com/powerline/fonts) - A collection of a dozen or so fonts patched to include Powerline glyphs.
* [Victor Mono](https://rubjo.github.io/victor-mono/) - Victor Mono is a free programming font with semi-connected cursive italics, symbol ligatures (!=, ->>, =>, ===, <=, >=, ++) and Latin, Cyrillic and Greek characters.
* [spacemono](https://github.com/googlefonts/spacemono) - Google's new original monospace display typeface family.

### OS-specific setup

#### fzf

To enable the enhanced history search, you'll need to install [fzf](https://github.com/junegunn/fzf/). Manual install instructions can be found at [fzf](https://github.com/junegunn/fzf) and os-specific instructions below.

#### macOS

<details><summary>macOS instructions</summary>

1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com) (optional). In my opinion, it is considerably nicer than the stock Terminal application that comes with macOS. There is an RCE flaw in all versions of iTerm 2 before 3.3.6, so update if you're using an affected version.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. Install GNU Stow with `brew install stow`
4. Homebrew has a newer version of `zsh` than the one Apple shipped with the OS before 11.6, so `brew install zsh` to install it.
5. Switch your shell to `zsh` if necessary - Apple has defaulted the shell for new users to `zsh` since macOS Catalina (10.15):
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    4. Select advanced options
    5. Set your login shell to `/bin/zsh` (or `/usr/local/bin/zsh` if you decided to use the version packaged by `brew`)
6. Install some Powerline-compatible or NerdFont fonts from one of the links in the Fonts section above.
    1. In iTerm 2, go to Preferences->Profile in your iTerm 2 preferences, then select one of the Powerline-compatible fonts you just installed.
    2. **Make sure you also specify a Powerline-compatible font for non-ASCII in your iTerm 2 preferences or the prompt separators and branch glyphs will show up garbled**.
7. Install `fzf` with `brew install fzf`

</details>

#### Linux

<details><summary>Linux instructions</summary>

1. Switch your shell to `zsh` with `chsh -s /bin/zsh`
2. Install GNU Stow - `sudo yum install -y stow` on Red Hat / CentOS systems, `sudo apt-get -y install stow` on Debian / Ubuntu.
3. Install `fzf` - `sudo apt-get install -y fzf` on Debian / Ubuntu, do a manual install on Red Hat / Centos - instructions are at [fzf](https://github.com/junegunn/fzf).
4. Install the patched font in a valid X font path. Valid font paths can be listed with `xset q`: `mv YourChosenPowerlineFont.otf ~/.fonts`
5. Update the font cache for the path the font was installed in (root privileges may be needed for updating the font cache for some paths): `fc-cache -vf ~/.fonts/`

After installing a Nerdfont or Powerline-compatible font, you will need to configure your terminal emulator to use your selected Powerline-compatible font. The name of the correct font usually ends with *for Powerline*.

If the Powerline symbols can't be seen or are garbled, try closing all instances of the terminal emulator. The X Server may also need to be restarted for the new font to load correctly.

If you still can’t see the new fonts, confirm that the font has been installed to a valid X font path.

If you get garbled branch glyphs, make sure there isn't a separate font setting for non-ASCII characters in your terminal application that you also need to set to use a Powerline-compatible font. Konsole needs to be set to use UTF-8 encoding, for example.

</details>

### Set up Zgenom and the starter kit

Now that your fonts and default shell have been set up, install [zgenom](https://github.com/jandamm/zgenom.git) and the dotfiles from this starter kit repository.

1. Install [Zgenom](https://github.com/jandamm/zgenom.git)
    1. `cd ~`
    2. `git clone https://github.com/jandamm/zgenom.git`
2. Install the starter kit
    1. `cd ~`
    2. `git clone https://github.com/unixorn/zsh-quickstart-kit.git`
3. Configure zsh by symlinking the `.zshrc`, `.zsh-functions`, `.zgen-setup` and `.zsh_aliases` from this repository into your `~`.
    1. You can do this with `stow` by:
        1. `cd zsh-quickstart-kit`
        2. `stow --target=~ zsh`. If you have issues using `~` as a target, do `stow --target="$HOME" zsh`. If you still have errors, symlink the files in the kit's `zsh` directory into your home directory.

The `.zshrc`, `.zsh_aliases` & `.zsh_functions` files included in this kit enable the plugins listed below.

## Contents of the kit

The zsh-quickstart-kit configures your ZSH environment so that it includes:

* Automatic periodic updates of both `zgenom` and your plugins
* Cross-session shared history so commands typed in one terminal window can be seen and searched in all your other `zsh` sessions on the same machine.
* Automatic deduplication of your command history.
* Many more tab completions, courtesy of the [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) repository, and periodic updating to the tip of master of that repository, so you get updates to the extra tab completions.
* Supercharged command history search with [fzf](https://github.com/junegunn/fzf).
* Syntax highlighting at the command line.
* Tab completion of Rakefile targets.
* Enabling [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)-compatible plugins and themes (via the [zgenom](https://github.com/jandamm/zgenom.git) framework).
* Various helper functions for interacting with macOS' clipboard, audio volume, Spotlight, and Quicklook. For your convenience, these will only load if you are on a macOS machine so that you can use the same plugin list on any *NIX system.
* If you've installed iTerm2's shell integration, it will automatically be loaded during shell startup.

### Included plugins

* [chrissicool/zsh-256color](https://github.com/chrissicool/zsh-256color) - Sets your terminal to 256 colors if available.
* [djui/alias-tips](https://github.com/djui/alias-tips) - Warns you when you have an alias for the command you just typed and tells you what it is.
* [eventi/noreallyjustfuckingstopalready](https://github.com/eventi/noreallyjustfuckingstopalready)- Deals with Apple's squirrelly DNS resolver. Only loads when you're running on macOS.
* [peterhurford/git-it-on.zsh](https://github.com/peterhurford/git-it-on.zsh) - Opens your current repository on GitHub, in your current branch.
* [robSis/zsh-completion-generator](https://github.com/RobSis/zsh-completion-generator) - Adds a tool to generate ZSH completion functions for programs missing them by parsing their `--help` output. Note that this doesn't happen dynamically; you'll have to explicitly run it to create a completion for each command missing one.
* [sharat87/pip-app](https://github.com/sharat87/pip-app) - A set of shell functions to make it easy to install small apps and utilities distributed with `pip`.
* [skx/sysadmin-util](https://github.com/skx/sysadmin-util) - A collection of scripts useful for sysadmins.
* [srijanshetty/docker-zsh](https://github.com/srijanshetty/docker-zsh) - Adds completions for `docker`.
* [stackexchange/blackbox](https://github.com/stackexchange/blackbox) - Tom Limoncelli's tool for storing secret information in a repository with GnuPG encryption, automatically decrypting as needed.
* [supercrabtree/k](https://github.com/supercrabtree/k) - `k` is a directory lister that also shows git status on files & directories.
* [unixorn/1password-op.plugin.zsh](https://github.com/unixorn/1password-op.plugin.zsh) - Tab completions for [1Password](https://1password.com)'s [op](https://developer.1password.com/docs/cli/get-started/) command line tool. Only installs itself if `op` is in your `$PATH`.
* [unixorn/autoupdate-zgenom](https://github.com/unixorn/autoupdate-zgenom) - Adds autoupdate (for both `zgenom` itself, and your plugins) to `zgenom`.
* [unixorn/bitbucket-git-helpers](https://github.com/unixorn/bitbucket-git-helpers.plugin.zsh) - Adds `git` helper scripts for bitbucket.
* [unixorn/fzf-zsh-plugin](https://github.com/unixorn/fzf-zsh-plugin) - This enables `fzf`-powered history search.
* [unixorn/git-extra-commands](https://github.com/unixorn/git-extra-commands) - A collection of extra helper scripts for `git`.
* [unixorn/jpb.zshplugin](https://github.com/unixorn/jpb.zshplugin) - Some of my standard aliases & functions.
* [unixorn/rake-completion.zshplugin](https://github.com/unixorn/rake-completion.zshplugin) - Reads the Rakefile in the current directory so you can tab-complete the Rakefile targets.
* [unixorn/tumult.plugin.zsh](https://github.com/unixorn/tumult.plugin.zsh) - Adds macOS-specific functions and scripts. This plugin only adds itself to your `$PATH` if you're running macOS to allow you to use the same plugin list on macOS and other systems.
* [zdharma-continuum/fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - Syntax highlighting as you type.
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Adds fish-like autosuggestions to your ZSH sessions.
* [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) - Tab completions for many more applications than come standard with ZSH.
* [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - Better history search.

The quickstart kit also uses `zgenom` to load oh-my-zsh and these plugins:

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

## Customizing the kit

### Behavior toggles

Running the following commands will toggle behavior the next time you start a shell session:

* Prompt selectors - We now use the [powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt. I won't change the prompt out from under people without a way for them to get the old behavior, so there are commands to switch back and forth.
  * `zsh-quickstart-select-powerlevel10k` -  Switch to the [powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt now used as the kit's default.
  * `zsh-quickstart-select-bullet-train` - Switch back to the [bullet-train](https://github.com/caiogondim/bullet-train.zsh) prompt originally used in the kit.
* You can disable printing the list of `ssh` keys by executing `zqs disable-ssh-key-listing`.
* `bash` prints `^C` when you're typing a command and hit control-c to cancel it, so it is easy to see it wasn't executed. By default, ZSH doesn't print the `^C`. I prefer seeing the `^C`, so by default, the quickstart traps `SIGINT` and prints the `^C`. You can disable this behavior by running `zqs disable-control-c-decorator` and enable it with `zqs enable-control-c-decorator`.

#### zqs

As of 2021-11-13, I've added a `zqs` command to start exposing some of the configurable parts in a more user-friendly way. The `zqs` command has the following subcommands:

##### zqs check-for-updates

Updates the quickstart kit if it has been longer than seven days since the last update.

##### zqs-disable-bindkey-handling

Disable `bindkey` setup and alias expansion in the quickstart `.zshrc` so people can use plugins like [globalias](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/globalias) to handle it instead.

##### zqs-enable-bindkey-handling

Let the quickstart's `.zshrc` configure `bindkey` setup and alias expansion. This is the default behavior.

##### zqs disable-omz-plugins

Set the quickstart to not include any oh-my-zsh plugins from the standard plugin list. Loading omz plugins can make terminal startup significantly slower.

##### zqs enable-control-c-decorator

Set the quickstart to create a `TRAPINT` handler in future `zsh` sessions to also display control-C when you type control-c. This is the default behavior.

##### zqs disable-control-c-decorator

Set the quickstart to not create the `TRAPINT` handler to display control-C when you type control-c in future `zsh` sessions.

##### zqs enable-omz-plugins

Sets the quickstart to include the oh-my-zsh plugins from the standard plugin list.

##### zqs enable-ssh-askpass-require

Enable the quickstart to prompt for your ssh passphrase on the command line.

##### zqs disable-ssh-askpass-require

The quickstart will prompt for your ssh passphrase via a gui program. Default behavior.

##### zqs-disable-ssh-key-listing

Don't print the loaded `ssh` keys when creating a new session.

##### zqs-enable-ssh-key-listing

Print the loaded `ssh` keys when creating a new session. This is the default behavior.

##### zqs-disable-ssh-key-loading

Don't load `ssh` keys when creating a new session. Useful if you're storing your private keys in a [yubikey](https://www.yubico.com/).

##### zqs-enable-ssh-key-loading

Load missing `ssh` private keys when creating a new session. This is the default behavior.

##### zqs-disable-zmv-autoloading

Don't run `autoload -U zmv` when creating a new session.

##### zqs-enable-zmv-autoloading

Run `autoload -U zmv` when creating a new session. This is the default behavior.

##### `zqs-disable-zsh-profiling

Disable ZSH's profiler. This is the default.

##### `zqs-enable-zsh-profiling

Turn on ZSH's profiler

##### zqs selfupdate

Force an immediate update of the quickstart kit.

##### zqs update

Update the quickstart kit and all your plugins.

##### zqs update-plugins

Updates all your plugins.

##### zqs cleanup

Cleanup unused plugins after removing them from the list

##### zqs get-setting

`zqs get-setting NAME [OPTIONAL default value]` prints the value of a `zqs` setting, or if unset and a default value was passed, the specified default.

##### zqs set-setting

`zqs set-setting NAME VALUE` writes a setting.

##### zqs delete-setting

`zqs delete-setting NAME` deletes a setting from `zqs`'s crude parameter store.

### Functions and Aliases

#### Customizing with ~/.zshrc.d

The `.zshrc` included in this kit will automatically source any files it finds in `~/.zshrc.d`. This happens after plugins are loaded. If you need to set variables or aliases before plugins are loaded, create files in `~/.zshrc.pre-plugins.d`.

This makes it easy for you to add extra functions and aliases without having to maintain a separate fork of this repository and allows you to configure the behavior of some of the plugins by setting environment variables.

The files will be sourced in alphanumeric order after loading all the plugins, and I suggest you use a naming scheme of `001-onething`, `002-something-else` etc., to ensure they're loaded in the order you expect.

### I like a plugin, but some of the aliases and functions it installs overwrite other commands or aliases I use

Make a file in `~/.zshrc.d` named something like `999-reset-aliases`. Because files in `~/.zshrc.d` are loaded after all the ZSH plugins, you can add lines like `unalias xyzzy` to remove an alias named `xyzzy`, or `unset -f abcd` to remove a function named `abcd`.

Once you've cleared all the unwanted aliases and functions, you can add new ones with your preferred names.

### ZSH options

The quickstart kit does an opinionated (i.e., my way) setup of ZSH options and adds some functions and aliases I like on my systems. I don't want you to have to maintain a separate fork if you don't like them and/or want to add your own, so the kit allows you to override or add behavior by creating fragment files that it will load during session startup.

#### Fragment file directories

You can customize the quickstart by adding files to its various `zshrc.d` directories.

If you want to set variables _before_ the quickstart starts loading plugins to alter their behavior, stick your fragment files in `~/.zshrc.pre-plugins.d`.

After the quickstart sets up its aliases, functions, plugins and ZSH options, it will source every fragment file in `~/.zshrc.d`.

To make it easier to have macOS, FreeBSD or Linux-specific settings tweaks, the quickstart also supports OS-specific pre & post `.zshrc.d` directories. If you want a file to only be sourced on a single OS, the quickstart also checks for `.zshrc.pre-plugins.$(uname).d` and `~/.zshrc.$(uname).d` during loading.

### Self-update Settings

The quickstart kit will automatically check for updates every seven days. If you want to change the interval, set `QUICKSTART_KIT_REFRESH_IN_DAYS` in a file in `~/.zshrc.d`. If you're going to disable self-updating entirely, add `unset QUICKSTART_KIT_REFRESH_IN_DAYS` in a file in `~/.zshrc.d`.

### Customizing the plugin list

I've included what I think is a good starter set of ZSH plugins in this repository. However, everyone has their preferences for their environment.

To make things easier to customize without users having to maintain their own forks, the kit provides two ways to customize the list of plugins it will load.

You can either add a fragment file to `~/.zshrc.add-plugins.d`, or you can make a `~/.zsh-quickstart-local-plugin` file.

#### Using fragment files

If all you want to do is add plugins to the standard list and you want to still automatically get any new changes I make to that standard list (new plugins, new locations when existing plugins are moved, etc) then adding a file into `~/.zshrc.add-plugins.d` with your extra plugins listed as `zgenom load githubuser/pluginrepo` (one line per plugin) is the way to go. The kit will load its plugins, then add yours on the end. You can add separate files with plugins in the `~/.zshrc.add-plugins.d` directory - my personal use case is having one file with all the plugins I use everywhere, and one that has extra plugins I only need on my work machines. This is the easiest option.

#### Complete plugin list replacement

If you don't care about future changes to the kit's plugins and want to fully replace the built-in list, then create a `~/.zsh-quickstart-local-plugins` file. When the kit detects a file named `~/.zsh-quickstart-local-plugins`, its `.zshrc` will source that **instead** of running the `load-starter-plugin-list` function defined in `~/.zgen-setup`.

**Using `~/.zsh-quickstart-local-plugins` is not additive. It will *completely replace* the kit-provided list of plugins.** If you want to just add more plugins, use the fragment file method above.

Creating a `.zsh-quickstart-local-plugins` from scratch is a pain, so to make customizing your plugin list easier, I've included a `.zsh-quickstart-local-plugins-example` file at the root of the repository that installs the same plugin list that the kit does by default that you can use as a starting point for your own `.zsh-quickstart-local-plugins` file.

Copy that to your `$HOME/.zsh-quickstart-local-plugins`, change the list, and the next time you start a terminal session, you'll get your plugin list loaded instead of the kit's defaults.

### Disabling zmv

The quickstart automatically autoloads `zmv`. If you want to disable that so you can configure it with another plugin or on your own, run `zqs disable-zmv-autoloading`.

### Disabling oh-my-zsh

If you don't want `zgenom` to load the oh-my-zsh defaults, run `zqs-disable-omz-plugins`.

## FAQ

### How do I reconfigure the prompt?

You may want to reconfigure your prompt after using it. The quickstart uses the [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme, so you can reconfigure your prompt by running `p10k configure`.

### Powerlevel 10k warns that there is console output during startup

You see a warning during session startup -

```sh
[WARNING]: Console output during zsh initialization detected.
When using Powerlevel10k with instant prompt, console output during zsh
initialization may indicate issues.
```

You can stifle this output by adding `typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet` in a fragment file in `~/.zshrc.pre-plugins.d`.

### I added a new completion plugin, and it isn't working

I've had reports that sometimes you may need to reset your completions after adding a new plugin.

```sh
rm ~/.zcompdump*
compinit
```

### I get a git error when I try to update the kit

You try to update the kit, and you get an error similar to this:

```sh
From https://github.com/unixorn/zsh-quickstart-kit
0c5bad9..2064c6b master -> origin/master

    755f689...e3f8677 switch-to-zgenom -> origin/switch-to-zgenom (forced update)
    Updating 0c5bad9..2064c6b
    error: Your local changes to the following files would be overwritten by merge:
    zsh/.zshrc
    Please commit your changes or stash them before you merge.
    Aborting
```

This happens when you edit a file provided by the quickstart kit, in this case, `.zshrc`. This is annoying, and to let you customize your ZSH settings without being forced to maintain your own fork of the kit, the kit-provided `.zshrc` will load any files it finds in the various `~/.zshrc.d` directories. See [Fragment File Directories](https://github.com/unixorn/zsh-quickstart-kit#fragment-file-directories) for more details.

### GNU stow is warning that stowing zsh would cause conflicts

You ran `stow --target=/Users/YourUsername zsh` in the top level of the repo and stow printed the following error:

```sh
WARNING! stowing zsh would cause conflicts:
  * existing target is neither a link nor a directory: .zshrc
All operations aborted.
```

Per @jefheaton, this is caused when trying to replace an existing `.zshrc` file. He fixed it by closing `~` in Finder so Finder wouldn't create a `.DS_Store` file, deleting the existing `.DS_Store` and removing the old `.zshrc`. You may have to rename it first if ZSH is keeping the file open, then delete it after closing all your Terminal/iTerm 2 windows.

### _arguments:comparguments:325: can only be called from completion function

This has been solved by running `zgen update` or switching to [zgenom](https://github.com/jandamm/zgenom). New users of the kit should already be running `zgenom`. Thanks @RonanJackson, for reporting the fix.

### Could not open a connection to your authentication agent

Confirm that `ssh-agent` is running. If not, Rob Montero has a good [blog post](https://rob.cr/blog/using-ssh-agent-mac-os-x/) on setting up `ssh-agent` on macOS, and here are [instructions](https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user) for starting `ssh-agent` with `systemd` on Linux.

### I want to pin a plugin version

The plugin standard doesn't include a standard way of determining a version. If you need to pin a version of a plugin, the easiest way to do it is to fork the plugin's repository and then have your `~/.zsh-quickstart-local-plugins` refer to that.

If you don't want to maintain a fork, you can also have `zgenom` load from a local directory. So clone the repository, then add something like
```sh
zgenom load ~/path/to/your/copy/of/example.plugin.zsh
```

Then you can tag working versions, pull from upstream for testing, and if the upstream doesn't work for you, check out your `last-working-version` tag, and `zgenom` will use your tagged version instead of the tip of the default branch.

## Other Resources

### ZSH

* For a list of other ZSH plugins, completions, and themes you might like to use, check out my [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins) list. It also contains a list of other ZSH [tutorials and starter kits](https://github.com/unixorn/awesome-zsh-plugins#generic-zsh).
* Justin Garrison has a good repository that details [Mastering ZSH](https://github.com/rothgar/mastering-zsh).

### Dotfiles in general

[dotfiles.github.io/](https://dotfiles.github.io/) has a lot of great resources for dotfiles - frameworks for managing them, configurations for editors, and other bootstraps with initial configurations to start from.

### Vim

If you're using vim, [spf13](http://vim.spf13.com/) is an excellent starter configuration and plugin collection.

## Thanks

Many thanks to all the contributors over the years who've helped make the quickstart better.

<a href="https://github.com/unixorn/zsh-quickstart-kit/graphs/contributors">
  <img src="https://contributors-img.web.app/image?repo=unixorn/zsh-quickstart-kit" />
</a>

Made with [contributors-img](https://contributors-img.web.app).
