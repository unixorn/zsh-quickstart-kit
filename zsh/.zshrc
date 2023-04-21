# Copyright 2006-2023 Joseph Block <jpb@unixorn.net>
#
# BSD licensed, see LICENSE.txt
#
# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"
#
# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
#
# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"
#
# Version 1.0.0
#
# If you want to change settings that are in this file, the easiest way
# to do it is by adding a file to ~/.zshrc.d or ~/.zshrc.pre-plugins.d that
# redefines the settings.
#
# All files in there will be sourced, and keeping your customizations
# there will keep you from having to maintain a separate fork of the
# quickstart kit.

# Check if a command exists
function can_haz() {
  which "$@" > /dev/null 2>&1
}

# Fix weirdness with intellij
if [[ -z "${INTELLIJ_ENVIRONMENT_READER}" ]]; then
  export POWERLEVEL9K_INSTANT_PROMPT='quiet'
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Valid font modes:
# flat, awesome-patched, awesome-fontconfig, nerdfont-complete, nerdfont-fontconfig
if [[ -r ~/.powerlevel9k_font_mode ]]; then
  POWERLEVEL9K_MODE=$(head -1 ~/.powerlevel9k_font_mode)
fi

# Unset COMPLETION_WAITING_DOTS in a file in ~/.zshrc.d if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

# Provide a unified way for the quickstart to get/set settings.
if [[ -f ~/.zqs-settings-path ]]; then
  _ZQS_SETTINGS_DIR=$(cat ~/.zqs-settings-path)
else
  _ZQS_SETTINGS_DIR="${HOME}/.zqs-settings"
fi
export _ZQS_SETTINGS_DIR

# _zqs-* functions are internal tooling for the quickstart. Modifying or unsetting
# them is likely to break things badly.

_zqs-trigger-init-rebuild() {
  rm -f ~/.zgen/init.zsh
  rm -f ~/.zgenom/init.zsh
}

# We need to load shell fragment files often enough to make it a function
function load-shell-fragments() {
  if [[ -z $1 ]]; then
    echo "You must give load-shell-fragments a directory path"
  else
    if [[ -d "$1" ]]; then
      if [ -n "$(/bin/ls -A $1)" ]; then
        for _zqs_fragment in $(/bin/ls -A $1)
        do
          if [ -r $1/$_zqs_fragment ]; then
            source $1/$_zqs_fragment
          fi
        done
        unset _zqs_fragment
      fi
    else
      echo "$1 is not a directory"
    fi
  fi
}

# Settings names have to be valid file names, and we're not doing any parsing here.
_zqs-get-setting() {
  # If there is a $2, we return that as the default value if there's
  # no settings file.
  local sfile="${_ZQS_SETTINGS_DIR}/${1}"
  if [[ -f "$sfile" ]]; then
    svalue=$(cat "$sfile")
  else
    if [[ $# -eq 2 ]]; then
      svalue=$2
    else
      svalue=''
    fi
  fi
  echo "$svalue"
}

_zqs-set-setting() {
  if [[ $# -eq 2 ]]; then
    mkdir -p "$_ZQS_SETTINGS_DIR"
    echo "$2" > "${_ZQS_SETTINGS_DIR}/$1"
  else
    echo "Usage _zqs-set-setting-value SETTINGNAME VALUE"
  fi
}

_zqs-delete-setting(){
  # We want to keep output clean when settings are cleared internally, so
  # use a separate function when called by a human we can display a warning
  # if the setting doesn't exist.
  local sfile="${_ZQS_SETTINGS_DIR}/${1}"
  if [[ -f "$sfile" ]]; then
    rm -f "$sfile"
  else
    echo "There is no settings file for ${1}"
  fi
}

_zqs-purge-setting() {
  local sfile="${_ZQS_SETTINGS_DIR}/${1}"
  rm -f "$sfile"
}

# Convert the old settings files into new style settings
function _zqs-update-stale-settings-files() {
  # Convert .zqs-additional-plugins to new format
  if [[ -f ~/.zqs-additional-plugins ]]; then
    mkdir -p ~/.zshrc.add-plugins.d
    sed -e 's/^./zgenom load &/' ~/.zqs-additional-plugins >> ~/.zshrc.add-plugins.d/0000-transferred-plugins
    rm -f ~/.zqs-additional-plugins
    echo "Plugins from .zqs-additional-plugins were moved to .zshrc.add-plugins.d/0000-transferred-plugins with a format change"
  fi
  if [[ -f ~/.zsh-quickstart-use-bullet-train ]]; then
    _zqs-set-setting bullet-train true
    rm -f ~/.zsh-quickstart-use-bullet-train
    echo "Converted old ~/.zsh-quickstart-use-bullet-train to new settings system"
  fi
  if [[ -f ~/.zsh-quickstart-no-omz ]]; then
    _zqs-set-setting load-omz-plugins false
    rm -f ~/.zsh-quickstart-no-omz
    echo "Converted old ~/.zsh-quickstart-no-omz to new settings system"
  fi
  if [[ -f ~/.zsh-quickstart-no-zmv ]]; then
    _zqs-set-setting no-zmv true
    rm -f ~/.zsh-quickstart-no-zmv
    echo "Converted old ~/.zsh-quickstart-no-zmv to new settings system"
  fi
  # Don't break existing user setups, but transition to a zqs setting to reduce
  # pollution in the user's environment.
  if [[ -z "ZSH_QUICKSTART_SKIP_TRAPINT" ]]; then
    echo "'ZSH_QUICKSTART_SKIP_TRAPINT' is deprecated in favor of running 'zqs disable-control-c-decorator' to write a settings knob."
    zqs-quickstart-disable-control-c-decorator
  fi
}

_zqs-update-stale-settings-files

# Add some quickstart feature toggle functions
function zsh-quickstart-select-bullet-train() {
  _zqs-set-setting bullet-train true
  _zqs-set-setting powerlevel10k false
  _zqs-trigger-init-rebuild
}

function zsh-quickstart-select-powerlevel10k() {
  rm -f ~/.zsh-quickstart-use-bullet-train
  _zqs-set-setting powerlevel10k true
  _zqs-set-setting bullet-train false
  _zqs-trigger-init-rebuild
}

# Binary feature settings functions should always be named
# zsh-quickstart-disable-FEATURE and zsh-quickstart-enable-FEATURE

function zsh-quickstart-disable-bindkey-handling() {
  _zqs-set-setting handle-bindkeys false
}

function zsh-quickstart-enable-bindkey-handling() {
  _zqs-set-setting handle-bindkeys true
}

function zqs-quickstart-disable-control-c-decorator() {
  _zqs-set-setting control-c-decorator false
  echo "Disabled the control-c decorator in future zsh sessions."
  echo "You can re-enable the quickstart's control-c decorator by running 'zqs enable-control-c-decorator'"
}

function zqs-quickstart-enable-control-c-decorator() {
  echo "The control-c decorator is enabled for future zsh sessions."
  echo "You can disable the quickstart's control-c decorator by running 'zqs disable-control-c-decorator'"
  _zqs-set-setting control-c-decorator true
}

function _zqs-enable-zmv-autoloading() {
  _zqs-set-setting no-zmv false
}

function _zqs-disable-zmv-autoloading() {
  _zqs-set-setting no-zmv true
}

function zsh-quickstart-disable-omz-plugins() {
  rm -f ~/.zsh-quickstart-no-omz
  _zqs-set-setting load-omz-plugins false
  _zqs-trigger-init-rebuild
}

function zsh-quickstart-enable-omz-plugins() {
  rm -f ~/.zsh-quickstart-no-omz
  _zqs-set-setting load-omz-plugins true
  _zqs-trigger-init-rebuild
}

function zsh-quickstart-set-ssh-askpass-require() {
  if [[ $(_zqs-get-setting ssh-askpass-require) == 'true' ]]; then
    export SSH_ASKPASS_REQUIRE=never
  fi
}

function zsh-quickstart-enable-ssh-askpass-require() {
  _zqs-set-setting enable-ssh-askpass-require true
}

function zsh-quickstart-disable-ssh-askpass-require() {
  _zqs-set-setting enable-ssh-askpass-require false
  zsh-quickstart-check-for-ssh-askpass
}

function zsh-quickstart-check-for-ssh-askpass() {
  if ! can_haz ssh-askpass; then
    echo "If you disable the ssh-askpass-require feature."
    echo "You'll need to install ssh-askpass for the quickstart to prompt,"
    echo "for your ssh key/s passphrase on shell startup."
    echo "This is the default behavior for ssh-add:"
    echo $(tput setaf 2)"https://www.man7.org/linux/man-pages/man1/ssh-add.1.html#ENVIRONMENT"$(tput sgr0)
  fi
}
# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH="$PATH:/sbin:/usr/sbin:/bin:/usr/bin"

# If you need to add extra directories to $PATH that are not checked for
# here, add a file in ~/.zshrc.d - then you won't have to maintain a
# fork of the kit.

# Conditional PATH additions
for path_candidate in /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/homebrew/bin \
  /opt/homebrew/sbin \
  /home/linuxbrew/.linuxbrew/bin \
  /home/linuxbrew/.linuxbrew/sbin \
  /opt/local/bin \
  /opt/local/sbin \
  /usr/local/bin \
  /usr/local/sbin \
  ~/.cabal/bin \
  ~/.cargo/bin \
  ~/.linuxbrew/bin \
  ~/.linuxbrew/sbin \
  ~/.rbenv/bin \
  ~/bin \
  ~/src/gocode/bin \
  ~/gocode
do
  if [[ -d "${path_candidate}" ]]; then
    path+=("${path_candidate}")
  fi
done
export PATH

# We will dedupe $PATH after loading ~/.zshrc.d/* so that any duplicates
# added there get deduped too.

# Deal with brew if it's installed. Note - brew can be installed outside
# of /usr/local, so use brew --prefix to find its bin and sbin directories.
if can_haz brew; then
  BREW_PREFIX=$(brew --prefix)
  if [[ -d "${BREW_PREFIX}/bin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/bin"
  fi
  if [[ -d "${BREW_PREFIX}/sbin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/sbin"
  fi
fi

# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/

if [[ -z "$LSCOLORS" ]]; then
  export LSCOLORS='Exfxcxdxbxegedabagacad'
fi
if [[ -z "$LS_COLORS" ]]; then
  export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
fi

load-our-ssh-keys() {
  if can_haz op; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
      export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    fi
    if [[ "$(uname -s)" == "Linux" ]]; then
      export SSH_AUTH_SOCK=~/.1password/agent.sock
    fi
  else
    # If keychain is installed let it take care of ssh-agent, else do it manually
    if can_haz keychain; then
      eval `keychain -q --eval`
    else
      if [ -z "$SSH_AUTH_SOCK" ]; then
        # If user has keychain installed, let it take care of ssh-agent, else do it manually
        # Check for a currently running instance of the agent
        RUNNING_AGENT="$(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
        if [ "$RUNNING_AGENT" = "0" ]; then
          if [ ! -d ~/.ssh ] ; then
            mkdir -p ~/.ssh
          fi
          # Launch a new instance of the agent
          ssh-agent -s &> ~/.ssh/ssh-agent
        fi
        eval $(cat ~/.ssh/ssh-agent)
      fi
    fi
  fi

  local key_manager=ssh-add

  if can_haz keychain; then
    key_manager=keychain
  fi

  # Fun with SSH
  if [ $($key_manager -l | grep -c "The agent has no identities." ) -eq 1 ]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
      # macOS allows us to store ssh key pass phrases in the keychain, so try
      # to load ssh keys using pass phrases stored in the macOS keychain.
      #
      # You can use ssh-add -K /path/to/key to store pass phrases into
      # the macOS keychain

      # macOS Monterey deprecates the -K and -A flags. They have been replaced
      # by the --apple-use-keychain and --apple-load-keychain flags.

      # check if Monterey or higher
      # https://scriptingosx.com/2020/09/macos-version-big-sur-update/
      if [[ $(sw_vers -productVersion | cut -d '.' -f 1) -ge "12" ]]; then
        # Load all ssh keys that have pass phrases stored in macOS keychain using new flags
        ssh-add --apple-load-keychain
      else ssh-add -qA
      fi
    fi

    for key in $(find ~/.ssh -type f -a \( -name '*id_rsa' -o -name '*id_dsa' -o -name '*id_ecdsa' -o -name '*id_ed25519' \))
    do
      if [ -f ${key} -a $(ssh-add -l | grep -F -c "$(ssh-keygen -l -f $key | awk '{print $2}')" ) -eq 0 ]; then
        $key_manager -q ${key}
      fi
    done
  fi
}

if [[ -z "$SSH_CLIENT" ]] || can_haz keychain; then
  # We're not on a remote machine, so load keys
  if [[ "$(_zqs-get-setting ssh-askpass-require)" == 'true' ]]; then
    zsh-quickstart-set-ssh-askpass-require
  fi
  load_ssh_keys="$(_zqs-get-setting load-ssh-keys true)"
  if [[ "$load_ssh_keys" != "false" ]]; then
    load-our-ssh-keys
  fi
fi

# Load helper functions before we load zgenom setup
if [ -r ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# Make it easy to prepend your own customizations that override the
# quickstart's defaults by loading all files from the
# ~/.zshrc.pre-plugins.d directory
mkdir -p ~/.zshrc.pre-plugins.d
load-shell-fragments ~/.zshrc.pre-plugins.d

# macOS doesn't have a python by default. This makes the omz python and
# zsh-completion-generator plugins sad, so if there isn't a python, alias
# it to python3
if ! can_haz python; then
  if can_haz python3; then
    alias python=python3
  fi
  # Ugly hack for zsh-completion-generator - but only do it if the user
  # hasn't already set GENCOMPL_PY
  if [[ -z "$GENCOMPL_PY" ]]; then
    export GENCOMPL_PY='python3'
    export ZSH_COMPLETION_HACK='true'
  fi
fi

# Now that we have $PATH set up and ssh keys loaded, configure zgenom.
# Start zgenom
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi

# Undo the hackery for issue 180
# Don't unset GENCOMPL_PY if we didn't set it
if [[ -n "$ZSH_COMPLETION_HACK" ]]; then
  unset GENCOMPL_PY
  unset ZSH_COMPLETION_HACK
fi

# Set some history options
#
# You can customize these by putting a file in ~/.zshrc.d with
# different settings - those files are loaded later specifically to
# make overriding these (and things set by plugins) easy without having
# to maintain a fork.
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# Keep a ton of history. You can override these without editing .zshrc by
# adding a file to ~/.zshrc.d that changes these variables.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

#ZSH Man page referencing the history_ignore parameter - https://manpages.ubuntu.com/manpages/kinetic/en/man1/zshparam.1.html
HISTORY_IGNORE="(cd ..|l[s]#( *)#|pwd *|exit *|date *|* --help)"

# Set some options about directories
setopt pushd_ignore_dups
#setopt pushd_silent
setopt AUTO_CD  # If a command is issued that can’t be executed as a normal command,
                # and the command is the name of a directory, perform the cd command
                # to that directory.

# Add some completions settings
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_MENU         # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.

# Miscellaneous settings
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.

setopt extended_glob # Enable more powerful glob features

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# How often to check for an update. If you want to override this, the
# easiest way is to add a script fragment in ~/.zshrc.d that unsets
# QUICKSTART_KIT_REFRESH_IN_DAYS.
QUICKSTART_KIT_REFRESH_IN_DAYS=7

# Disable Oh-My-ZSH's internal updating. Let it get updated when user
# does a zgen update. Closes #62.
DISABLE_AUTO_UPDATE=true

if [[ $(_zqs-get-setting handle-bindkeys true) == 'true' ]]; then
  # Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
  globalias() {
    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
      zle _expand_alias
      zle expand-word
    fi
    zle self-insert
  }

  zle -N globalias

  bindkey " " globalias
  bindkey "^ " magic-space           # control-space to bypass completion
  bindkey -M isearch " " magic-space # normal space during searches
fi

# Make it easier to customize the quickstart to your needs without
# having to maintain your own fork.

# Stuff that works on bash or zsh
if [ -r ~/.sh_aliases ]; then
  source ~/.sh_aliases
fi

# Stuff only tested on zsh, or explicitly zsh-specific
if [ -r ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

export LOCATE_PATH=/var/db/locate.database

# Load AWS credentials when present
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
  export JAVA_HOME=/Library/Java/Home
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  # Load macOS-specific aliases
  # Apple renamed the OS, so use the macos one first
  [ -r ~/.macos_aliases ] && source ~/.macos_aliases
  if [ -d ~/.macos_aliases.d ]; then
    load-shell-fragments ~/.macos_aliases.d
  fi

  # Keep supporting the old name, but emit a deprecation warning
  [ -r ~/.osx_aliases ] && source ~/.osx_aliases
  if [ -d ~/.osx_aliases.d ]; then
    echo "Apple renamed the os to macos - the .osx_aliases.d directory is deprecated in favor of .macos_aliases.d"
    load-shell-fragments ~/.osx_aliases.d
  fi
fi

# deal with screen, if we're using it - courtesy MacOSXHints.com
# Login greeting ------------------
if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
  detached_screens=$(screen -list | grep Detached)
  if [ ! -z "$detached_screens" ]; then
    echo "+---------------------------------------+"
    echo "| Detached screens are available:       |"
    echo "$detached_screens"
    echo "+---------------------------------------+"
  fi
fi

# These need to be done after $PATH is set up so we can find
# grc and exa

# Set up colorized ls when gls is present - it's installed by grc
# shellcheck disable=SC2154
if (( $+commands[gls] )); then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# When present, use exa instead of ls
if can_haz exa; then
  if [[ -z "$EXA_TREE_IGNORE" ]]; then
    EXA_TREE_IGNORE=".cache|cache|node_modules|vendor|.git"
  fi

  if [[ "$(exa --help | grep -c git)" == 0 ]]; then
    # Not every linux exa build has git support compiled in
    alias l='exa -al --icons --time-style=long-iso --group-directories-first --color-scale'
  else
    alias l='exa -al --icons --git --time-style=long-iso --group-directories-first --color-scale'
  fi
  alias ls='exa --group-directories-first'

  # Don't step on system-installed tree command
  if ! can_haz tree; then
    alias tree='exa --tree'
  fi
fi

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# Load any custom zsh completions we've installed
if [[ -d ~/.zsh-completions.d ]]; then
  load-shell-fragments ~/.zsh-completions.d
fi
if [[ -d ~/.zsh-completions ]]; then
  echo '~/.zsh_completions is deprecated in favor of ~/.zsh_completions.d'
  load-shell-fragments ~/.zsh-completions
fi

# Load zmv
if [[ $(_zqs-get-setting no-zmv false) == 'false' ]]; then
  autoload -U zmv
fi

# Make it easy to append your own customizations that override the
# quickstart's defaults by loading all files from the ~/.zshrc.d directory
mkdir -p ~/.zshrc.d
load-shell-fragments ~/.zshrc.d

# If GOPATH is defined, add it to $PATH
if [[ -n "$GOPATH" ]]; then
  if [[ -d "$GOPATH" ]]; then
    export PATH="$PATH:$GOPATH"
  fi
fi

# Now that .zshrc.d has been processed, we dedupe $PATH using a ZSH builtin
# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path;

# If desk is installed, load the Hook for desk activation
[[ -n "$DESK_ENV" ]] && source "$DESK_ENV"

# Do selfupdate checking. We do this after processing ~/.zshrc.d to make the
# refresh check interval easier to customize.
#
# If they unset QUICKSTART_KIT_REFRESH_IN_DAYS in one of the fragments
# in ~/.zshrc.d, then we don't do any selfupdate checking at all.

_load-lastupdate-from-file() {
  local now=$(date +%s)
  if [[ -f "${1}" ]]; then
    local last_update=$(cat "${1}")
  else
    local last_update=0
  fi
  local interval="$(expr ${now} - ${last_update})"
  echo "${interval}"
}

_update-zsh-quickstart() {
  local _zshrc_loc=~/.zshrc
  if [[ ! -L "${_zshrc_loc}" ]]; then
    echo ".zshrc is not a symlink, skipping zsh-quickstart-kit update"
  else
    local _link_loc=${_zshrc_loc:A};
    if [[ "${_link_loc/${HOME}}" == "${_link_loc}" ]]; then
      pushd $(dirname "${HOME}/${_zshrc_loc:A}");
    else
      pushd $(dirname ${_link_loc});
    fi;
      local gitroot=$(git rev-parse --show-toplevel)
      if [[ -f "${gitroot}/.gitignore" ]]; then
        if [[ $(grep -c zsh-quickstart-kit "${gitroot}/.gitignore") -ne 0 ]]; then
          # Cope with switch from master to main
          zqs_current_branch=$(git rev-parse --abbrev-ref HEAD)
          git fetch
          # Determine the repo default branch and switch to it unless we're in testing mode
          zqs_default_branch="$(git remote show origin | grep 'HEAD branch' | awk '{print $3}')"
          if [[ "$zqs_current_branch" == 'master' ]]; then
            echo "The ZSH Quickstart Kit has switched default branches to $zqs_default_branch"
            echo "Changing branches in your local checkout from $zqs_current_branch to $zqs_default_branch"
            git checkout "$zqs_default_branch"
          fi
          if [[ "$zqs_current_branch" != "$zqs_default_branch" ]]; then
            echo "Using $zqs_current_branch instead of $zqs_default_branch"
          fi
          echo "---- updating $zqs_current_branch ----"
          git pull
          date +%s >! ~/.zsh-quickstart-last-update
          unset zqs_default_branch
          unset zqs_current_branch
        fi
      else
        echo 'No quickstart marker found, is your quickstart a valid git checkout?'
      fi
    popd
  fi
}

_check-for-zsh-quickstart-update() {
  local day_seconds=$(expr 24 \* 60 \* 60)
  local refresh_seconds=$(expr "${day_seconds}" \* "${QUICKSTART_KIT_REFRESH_IN_DAYS}")
  local last_quickstart_update=$(_load-lastupdate-from-file ~/.zsh-quickstart-last-update)

  if [ ${last_quickstart_update} -gt ${refresh_seconds} ]; then
    echo "It has been $(expr ${last_quickstart_update} / ${day_seconds}) days since your zsh quickstart kit was updated"
    echo "Checking for zsh-quickstart-kit updates..."
    _update-zsh-quickstart
  fi
}

if [[ ! -z "$QUICKSTART_KIT_REFRESH_IN_DAYS" ]]; then
  _check-for-zsh-quickstart-update
  # unset QUICKSTART_KIT_REFRESH_IN_DAYS
fi

# Fix bracketed paste issue
# Closes #73
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Load iTerm shell integrations if found.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize your prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ ! -f ~/.p10k.zsh ]]; then
  echo "Run p10k configure or edit ~/.p10k.zsh to configure your prompt"
else
  source ~/.p10k.zsh
fi

if [[ $(_zqs-get-setting list-ssh-keys true) == 'true' ]]; then
  echo
  echo "Current SSH Keys:"
  ssh-add -l
  echo
fi

if [[ $(_zqs-get-setting control-c-decorator 'true') == 'true' ]]; then
  # Original source: https://vinipsmaker.wordpress.com/2014/02/23/my-zsh-config/
  # bash prints ^C when you're typing a command and control-c to cancel, so it
  # is easy to see it wasn't executed. By default, ZSH doesn't print the ^C.
  # We trap SIGINT to make it print the ^C.
  TRAPINT() {
    print -n -u2 '^C'
    return $((128+$1))
  }
fi

if ! can_haz fzf; then
  echo "$?"
  echo "You'll need to install fzf or your history search will be broken."
  echo
  echo
  echo "Install instructions can be found at https://github.com/junegunn/fzf/"
fi

function zqs-help() {
  echo "The zqs command allows you to manipulate your ZSH quickstart."
  echo
  echo "Quickstart action commands:"
  echo "zqs check-for-updates - Update the quickstart kit if it has been longer than $QUICKSTART_KIT_REFRESH_IN_DAYS days since the last update."
  echo "zqs selfupdate - Force an immediate update of the quickstart kit"
  echo "zqs update - Update the quickstart kit and all your plugins"
  echo "zqs update-plugins - Update your plugins"
  echo "zqs cleanup - Cleanup unused plugins after removing them from the list"
  echo ""
  echo "Quickstart settings commands:"
  echo "zqs disable-bindkey-handling - Set the quickstart to not touch any bindkey settings. Useful if you're using another plugin to handle it."
  echo "zqs enable-bindkey-handling - Set the quickstart to configure your bindkey settings. This is the default behavior."
  echo "zqs enable-control-c-decorator - Creates a TRAPINT function to display '^C' when you type control-c instead of being silent. Default behavior."
  echo "zqs disable-control-c-decorator - No longer creates a TRAPINT function to display '^C' when you type control-c."
  echo "zqs disable-omz-plugins - Set the quickstart to not load oh-my-zsh plugins if you're using the standard plugin list"
  echo "zqs enable-omz-plugins - Set the quickstart to load oh-my-zsh plugins if you're using the standard plugin list"
  echo "zqs enable-ssh-askpass-require - Set the quickstart to prompt for your ssh passphrase on the command line."
  echo "zqs disable-ssh-askpass-require - Set the quickstart to prompt for your ssh passphrase via a gui program. This is the default behavior"
  echo "zqs disable-ssh-key-listing - Set the quickstart to not display all the loaded ssh keys"
  echo "zqs enable-ssh-key-listing - Set the quickstart to display all the loaded ssh keys. This is the default behavior."
  echo "zqs disable-ssh-key-loading - Set the quickstart to not load your ssh keys. Useful if you're storing them in a yubikey."
  echo "zqs enable-ssh-key-loading - Set the quickstart to load your ssh keys if they aren't already in an ssh agent. This is the default behavior."
  echo "zqs disable-zmv-autoloading - Set the quickstart to not run 'autoload -U zmv'. Useful if you're using another plugin to handle it."
  echo "zqs enable-zmv-autoloading - Set the quickstart to run 'autoload -U zmv'. This is the default behavior."
  echo "zqs delete-setting SETTINGNAME - Remove a zqs setting file"
  echo "zqs get-setting SETTINGNAME [optional default value] - load a zqs setting"
  echo "zqs set-setting SETTINGNAME value - Set an arbitrary zqs setting"
}

function zqs() {
  case "$1" in
    'check-for-updates')
      _check-for-zsh-quickstart-update
      ;;
    'disable-bindkey-handling')
      zsh-quickstart-disable-bindkey-handling
      ;;
    'enable-bindkey-handling')
      zsh-quickstart-enable-bindkey-handling
      ;;
    'disable-control-c-decorator')
      zqs-quickstart-disable-control-c-decorator
      ;;
    'enable-control-c-decorator')
      zqs-quickstart-enable-control-c-decorator
      ;;

    'disable-zmv-autoloading')
      _zqs-disable-zmv-autoloading
      ;;
    'enable-zmv-autoloading')
      _zqs-enable-zmv-autoloading
      ;;
    'disable-omz-plugins')
      zsh-quickstart-disable-omz-plugins
      ;;
    'enable-omz-plugins')
      zsh-quickstart-enable-omz-plugins
      ;;
    'enable-ssh-askpass-require')
      zsh-quickstart-enable-ssh-askpass-require
      ;;
    'disable-ssh-askpass-require')
      zsh-quickstart-disable-ssh-askpass-require
      ;;
    'enable-ssh-key-listing')
      _zqs-set-setting list-ssh-keys true
      ;;
    'disable-ssh-key-listing')
      _zqs-set-setting list-ssh-keys false
      ;;
    'disable-ssh-key-loading')
      _zqs-set-setting load-ssh-keys false
      ;;
    'enable-ssh-key-loading')
      _zqs-set-setting load-ssh-keys true
      ;;
    'selfupdate')
      _update-zsh-quickstart
      ;;
    'update')
      _update-zsh-quickstart
      zgenom update
      ;;
    'update-plugins')
      zgenom update
      ;;
    'cleanup')
      zgenom clean
      ;;
    'delete-setting')
      shift
      _zqs-delete-setting $@
      ;;
    'get-setting')
      shift
      _zqs-get-setting $@
      ;;
    'set-setting')
      shift
      _zqs-set-setting $@
      ;;
    *)
      zqs-help
      ;;

  esac
}
