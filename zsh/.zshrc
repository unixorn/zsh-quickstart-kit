# Copyright 2006-2021 Joseph Block <jpb@unixorn.net>
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
# to do it is by adding a file to ~/.zshrc.d that redefines the sttings.
#
# All files in there will be sourced, and keeping your customizations
# there will keep you from having to maintain a separate fork of the
# quickstart kit.

# Check if a command exists
function can_haz() {
  which "$@" > /dev/null 2>&1
}

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

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"

# If you need to add extra directories to $PATH that are not checked for
# here, add a file in ~/.zshrc.d - then you won't have to maintain a
# fork of the kit.

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  ~/.cabal/bin \
  ~/.cargo/bin \
  ~/.rbenv/bin \
  ~/bin \
  ~/src/gocode/bin \
  ~/gocode
do
  if [[ -d "${path_candidate}" ]]; then
    export PATH="${PATH}:${path_candidate}"
  fi
done

# Deal with brew if it's installed. Note - brew can be installed outside
# of /usr/local, so add its bin and sbin directories.
if can_haz brew; then
  BREW_PREFIX=$(brew --prefix)
  if [[ -d "${BREW_PREFIX}/bin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/bin"
  fi
  if [[ -d "${BREW_PREFIX}/sbin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/sbin"
  fi
elif [[ -d /opt/homebrew ]]; then
  BREW_PREFIX=/opt/homebrew
  if [[ -d "${BREW_PREFIX}/bin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/bin"
  fi
  if [[ -d "${BREW_PREFIX}/sbin" ]]; then
    export PATH="$PATH:${BREW_PREFIX}/sbin"
  fi
fi

# We will dedupe $PATH after loading ~/.zshrc.d/* so that any duplicates
# added there get deduped too.

# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/

export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

load-our-ssh-keys() {
  if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="$(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> ~/.ssh/ssh-agent
   fi
   eval $(cat ~/.ssh/ssh-agent)
  fi
  # Fun with SSH
  if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
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
      if [[ $(sw_vers -buildVersion) > "21" ]]; then
        # Load all ssh keys that have pass phrases stored in macOS keychain using new flags
        ssh-add --apple-load-keychain
      else ssh-add -qA
      fi
    fi

    for key in $(find ~/.ssh -type f -a \( -name '*id_rsa' -o -name '*id_dsa' -o -name '*id_ecdsa' \))
    do
      if [ -f ${key} -a $(ssh-add -l | grep -F -c "$(ssh-keygen -l -f $key | awk '{print $2}')" ) -eq 0 ]; then
        if ( which keychain &> /dev/null ); then
          keychain ${key} &> /dev/null
        else
          ssh-add ${key} &> /dev/null
        fi
      fi
    done
    if ( which keychain &> /dev/null ); then
      if [[ -r ~/.keychain/$(hostname)-sh ]]; then
        source ~/.keychain/$(hostname)-sh
      fi
    fi
  fi
}

if [[ -z "$SSH_CLIENT" ]]; then
  # We're not on a remote machine, so load keys
  load-our-ssh-keys
fi

# Now that we have $PATH set up and ssh keys loaded, configure zgenom.

# Start zgenom
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
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
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

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

if [ -r ~/.zsh_functions ]; then
  source ~/.zsh_functions
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
  # Load macOS-specific aliases - keep supporting the old name
  [ -f ~/.osx_aliases ] && source ~/.osx_aliases
  if [ -d ~/.osx_aliases.d ]; then
    for alias_file in ~/.osx_aliases.d/*
    do
      source "$alias_file"
    done
  fi

  # Apple renamed the OS, so...
  [ -f ~/.macos_aliases ] && source ~/.macos_aliases
  if [ -d ~/.macos_aliases.d ]; then
    for alias_file in ~/.macos_aliases.d/*
    do
      source "$alias_file"
    done
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

# grc colorizes the output of a lot of commands. If the user installed it,
# use it.

# Try and find the grc setup file
if (( $+commands[grc] )); then
  GRC_SETUP='/usr/local/etc/grc.bashrc'
fi
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  GRC_SETUP="$(brew --prefix)/etc/grc.bashrc"
fi
if [[ -r "$GRC_SETUP" ]]; then
  source "$GRC_SETUP"
fi
unset GRC_SETUP

if (( $+commands[grc] ))
then
  function ping5(){
    grc --color=auto ping -c 5 "$@"
  }
else
  alias ping5='ping -c 5'
fi

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# Load any custom zsh completions we've installed
if [[ -d ~/.zsh-completions ]]; then
  for completion in ~/.zsh-completions/*
  do
    if [[ -r "$completion" ]]; then
      source "$completion"
    else
      echo "Can't read $completion"
    fi
  done
fi

# Load zmv
if [[ ! -f ~/.zsh-quickstart-no-zmv ]]; then
  autoload -U zmv
fi

# Make it easy to append your own customizations that override the
# quickstart's defaults by loading all files from the ~/.zshrc.d directory
mkdir -p ~/.zshrc.d
if [ -n "$(/bin/ls -A ~/.zshrc.d)" ]; then
  for dotfile in $(/bin/ls -A ~/.zshrc.d)
  do
    if [ -r ~/.zshrc.d/$dotfile ]; then
      source ~/.zshrc.d/$dotfile
    fi
  done
fi

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
  if [[ ! -L ~/.zshrc ]]; then
    echo ".zshrc is not a symlink, skipping zsh-quickstart-kit update"
  else
    local _link_loc=$(readlink ~/.zshrc);
    if [[ "${_link_loc/${HOME}}" == "${_link_loc}" ]]; then
      pushd $(dirname "${HOME}/$(readlink ~/.zshrc)");
    else
      pushd $(dirname ${_link_loc});
    fi;
      local gitroot=$(git rev-parse --show-toplevel)
      if [[ -f "${gitroot}/.gitignore" ]]; then
        if [[ $(grep -c zsh-quickstart-kit "${gitroot}/.gitignore") -ne 0 ]]; then
          echo "---- updating ----"
          # Cope with switch from master to main
          zqs_current_branch=$(git rev-parse --abbrev-ref HEAD)
          git fetch
          # Determine the repo default branch and switch to it
          zqs_default_branch="$(git remote show origin | grep 'HEAD branch' | awk '{print $3}')"
          if [[ "$zqs_default_branch" != "$zqs_current_branch" ]]; then
            echo "The ZSH Quickstart Kit has switched default branches to $zqs_default_branch"
            echo "Changing branches in your local checkout from $zqs_current_branch to $zqs_default_branch"
            git checkout "$zqs_default_branch"
          fi
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

if [[ -z "$DONT_PRINT_SSH_KEY_LIST" ]]; then
  echo
  echo "Current SSH Keys:"
  ssh-add -l
  echo
fi

if [[ -z "ZSH_QUICKSTART_SKIP_TRAPINT" ]]; then
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
  echo "options:"
  echo "zqs check-for-updates - Update the quickstart kit if it has been longer than $QUICKSTART_KIT_REFRESH_IN_DAYS days since the last update."
  echo "zqs selfupdate - Force an immediate update of the quickstart kit"
}

function zqs() {
  case "$1" in
    'check-for-updates')
      _check-for-zsh-quickstart-update
      ;;
    'selfupdate')
      _update-zsh-quickstart
      ;;
    *)
      zqs-help
      ;;

  esac
}