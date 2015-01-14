# On OS X
1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com). Seriously, never use Terminal again.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. ```brew install stow```
4. Homebrew has a newer version of zsh than the one Apple ships, so `brew install zsh` to get it.
5. Switch your shell to zsh
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    4. Select advanced options
    5. Set your login shell to `/bin/zsh` (`/usr/local/bin/zsh` if you decided to use a newer version from brew)
6. Install the powerline patched fonts from [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts), they include the pretty branch icon that the theme in this .zshrc uses. You'll need to clone that repository, then copy the fonts into `~/Library/Fonts`. Select one of them in your profile in your iTerm 2 preferences.

# On Linux
1. Switch your shell to zsh with chsh `chsh -s /bin/zsh`
2. Install GNU Stow - `yum install -y stow` on Red Hat / CentOS systems

# On both
1. Install [Zgen](https://github.com/tarjoilija/zgen)
    1. `cd ~`
    2. `git clone git@github.com:tarjoilija/zgen.git`
2. Configure zsh by symlinking the .zshrc, .zsh_aliases and .zsh-completions from this repo into your ~ with stow by running `stow --target=/Users/YourUsername zsh` in the top level of this repository. Replace `/Users/YourUsername` with `/home/YourUsername` if you're on Linux.

The included `.zshrc`, `.zsh_aliases` & `.zsh_functions` files enable:
* Appending your own customizations (stick them in ~/.zshrc.local, .zsh_aliases.local or .zsh_functions.local)
* automatic periodic update of zgen and your plugins
* cross-session shared history
* deduping your command history
* oh-my-zsh plugins and themes (via [zgen](https://github.com/tarjoilija/zgen))
* proper command history search
* syntax highlighting at the command line
* tab completion of Rakefile targets
* various helper functions for interacting with OS X's clipboard and quicklook
