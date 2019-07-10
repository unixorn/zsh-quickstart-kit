# Changelog

## 0.6

* Stop stepping on OS-provided `$PATH`.

## 0.5.2
* Added zsh-autosuggestions plugin

## 0.5

* Added Changes file
* Switched to using `~/.zshrc.d` files instead of a single `.zshrc.local` file
* Stopped trying to be so clever about modification times so newbs could understand how it was working
* Made it easier for users to customize, we now allow them to use their own plugin list if they create `.zgen-local-plugins`
* Broke out a lot of the OS X specific functions and aliases into a separate plugin, [tumult.plugin.zsh](https://github.com/unixorn/tumult.plugin.zsh) that only loads itself when it detects it is being run on an OS X system.
* Added font installation instructions for Linux
* We now de-duplicate your $PATH after loading everything
* Added self-update capability
