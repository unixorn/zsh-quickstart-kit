# Switch to iTerm2
Download iTerm2 from http://www.iterm2.com. Never use Terminal again.

# Switch to zsh
1. Switch your shell to zsh
    1. System Preferences -> Users & Groups.
    2. Unlock the preferences
    3. Select your user
    3. Select advanced options
    4. Set your login shell to /bin/zsh (/usr/local/bin/zsh if you're using a newer version from brew)
2. Install Antigen
    1. ```cd ~```
    2. ```git clone git@github.com:zsh-users/antigen.git```
3. Configure zsh by copying the .zshrc, .zsh_aliases and .zsh-completions from this repo into your ~
