# On OS X
1. Download iTerm2 from [http://www.iterm2.com](http://www.iterm2.com). Never use Terminal again.
2. Install the current version of Homebrew from [http://brew.sh/](http://brew.sh/).
3. ```brew install stow```
4. Switch your shell to zsh
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    3. Select advanced options
    4. Set your login shell to ```/bin/zsh``` (```/usr/local/bin/zsh``` if you're using a newer version from brew)
5. Install the powerline patched fonts from [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts), they include the pretty branch icon that the theme in this .zshrc uses

# On Linux
1. Switch your shell to zsh with chsh ```chsh -s /bin/zsh```
2. Install GNU Stow - ```yum install -y stow``` on Red Hat / CentOS systems

# On both
1. Install Antigen
    1. ```cd ~```
    2. ```git clone git@github.com:zsh-users/antigen.git```
2. Configure zsh by symlinking the .zshrc, .zsh_aliases and .zsh-completions from this repo into your ~ with stow by running ```stow zsh``` in the top level of this repository.

The included .zshrc and .zsh_aliases files enable:
* cross-session shared history
* proper command history search
* deduping your command history
* automatic periodic update of antigen and your plugins
* syntax highlighting at the command line
* oh-my-zsh plugins and themes (via antigen)
* tab completion of Rakefile targets
* various helper functions for interacting with OS X's clipboard and quicklook
* Appending your own customizations (stick them in ~/.zshrc.local)
