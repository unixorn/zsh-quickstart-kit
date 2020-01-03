# Changelog

## 1.0.0

* It's been four years, this is 1.0
* Switch to powerlevel10k prompt instead of bullettrain. If you want to keep bullettrain, run `zsh-quickstart-select-bullettrain`, and you can switch to p10k with `zsh-quickstart-select-powerlevel10k`

## 0.7

* autoload `zmv` by default
* Allow disabling oh-my-zsh inclusion by creating `~/.zsh-quickstart-no-omz`

## 0.6

* Stop stepping on OS-provided `$PATH`.

## 0.5.2

* Added zsh-autosuggestions plugin

## 0.5

* Added Changes file
* Switched to using `~/.zshrc.d` files instead of a single `.zshrc.local` file
* Stopped trying to be so clever about modification times so new users could understand how it was working
* Made it easier for users to customize without having to maintain a fork, we now allow them to use their own plugin list if they create `.zgen-local-plugins`
* Broke out a lot of the OS X specific functions and aliases into a separate plugin, [tumult.plugin.zsh](https://github.com/unixorn/tumult.plugin.zsh) that only loads itself when it detects it is being run on an OS X system.
* Added font installation instructions for Linux
* We now de-duplicate your `$PATH` after loading everything
* Added self-update capability
