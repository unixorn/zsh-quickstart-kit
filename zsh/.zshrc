# Copyright 2006-2019 Joseph Block <jpb@apesseekingknowledge.net>
#
# BSD licensed, see LICENSE.txt

# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

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

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /Applications/Xcode.app/Contents/Developer/usr/bin \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  ~/.cabal/bin \
  ~/.cargo/bin \
  ~/.rbenv/bin \
  ~/bin \
  ~/src/gocode/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH="${PATH}:${path_candidate}"
  fi
done

# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/

export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# Fun with SSH
if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS allows us to store ssh key pass phrases in the keychain, so try
    # to load ssh keys using pass phrases stored in the macOS keychain.
    #
    # You can use ssh-add -K /path/to/key to store pass phrases into
    # the macOS keychain
    ssh-add -k
  fi
fi

for key in $(find ~/.ssh -type f -a \( -name id_rsa -o -name id_dsa -name id_ecdsa \))
do
  if [ -f ${key} -a $(ssh-add -l | grep -c "${key//$HOME\//}" ) -eq 0 ]; then
    # ssh-add ${key}
  fi
done

# Now that we have $PATH set up and ssh keys loaded, configure zgen.

# start zgen
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi
# end zgen

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# set some more options
setopt pushd_ignore_dups
#setopt pushd_silent

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# How often to check for an update. If you want to override this, the
# easiest way is to add a script fragment in ~/.zshrc.d that unsets
# QUICKSTART_KIT_REFRESH_IN_DAYS.
QUICKSTART_KIT_REFRESH_IN_DAYS=7

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

# Customize to your needs...
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

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
  export JAVA_HOME=/Library/Java/Home
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  # Load macOS-specific aliases
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

if [ -f /usr/local/etc/grc.bashrc ]; then
  source "$(brew --prefix)/etc/grc.bashrc"

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
if [ -d ~/.zsh-completions ]; then
  for completion in ~/.zsh-completions/*
  do
    source "$completion"
  done
fi

echo
echo "Current SSH Keys:"
ssh-add -l
echo

# Honor old .zshrc.local customizations, but print deprecation warning.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
  echo '~/.zshrc.local is deprecated - use files in ~/.zshrc.d instead. Future versions of zsh-quickstart-kits will no longer load it'
fi

# Make it easy to append your own customizations that override the above by
# loading all files from the ~/.zshrc.d directory
mkdir -p ~/.zshrc.d
if [ -n "$(/bin/ls ~/.zshrc.d)" ]; then
  for dotfile in ~/.zshrc.d/*
  do
    if [ -r "${dotfile}" ]; then
      source "${dotfile}"
    fi
  done
fi

# In case a plugin adds a redundant path entry, remove duplicate entries
# from PATH
#
# This snippet is from Mislav Marohnić <mislav.marohnic@gmail.com>'s
# dotfiles repo at https://github.com/mislav/dotfiles
dedupe_path() {
  typeset -a paths result
  paths=($path)

  while [[ ${#paths} -gt 0 ]]; do
    p="${paths[1]}"
    shift paths
    [[ -z ${paths[(r)$p]} ]] && result+="$p"
  done

  export PATH=${(j+:+)result}
}

dedupe_path

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
    if [[ "${_link_loc/${HOME}}" == "${_link_loc}" ]] then
      pushd $(dirname "${HOME}/$(readlink ~/.zshrc)");
    else
      pushd $(dirname ${_link_loc});
    fi;
      local gitroot=$(git rev-parse --show-toplevel)
      if [[ -f "${gitroot}/.gitignore" ]]; then
        if [[ $(grep -c zsh-quickstart-kit "${gitroot}/.gitignore") -ne 0 ]]; then
          echo "---- updating ----"
          git pull
          date +%s >! ~/.zsh-quickstart-last-update
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
  unset QUICKSTART_KIT_REFRESH_IN_DAYS
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
