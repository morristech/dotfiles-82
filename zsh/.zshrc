ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eddiezane"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
plugins=(git eddiezane golang docker kube-ps1)
# FPATH must be set before calling compinit. Sourcing oh-my-zsh calls it.
FPATH=/opt/linuxbrew/share/zsh/site-functions:$FPATH
source $ZSH/oh-my-zsh.sh
unsetopt auto_name_dirs
setopt HIST_IGNORE_SPACE

# autoload -U compinit && compinit

export KUBE_PS1_ENABLED=off

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export EDITOR=nvim
export GOPATH=/home/eddiezane/Codez/GOPATH

export nvim_path=$(which nvim)
alias vim=$nvim_path

if [[ -f /etc/arch-release ]]; then
  export BROWSER=/usr/bin/google-chrome-stable;
  alias bu="sudo yay -Syu"
else
  alias bu="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade && brew upgrade"
fi

# Don't double set path in tmux
if [[ -z "$TMUX" ]]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH

  # kubectl krew
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

  if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  elif [ -f /opt/linuxbrew/bin/brew ]; then
    eval $(/opt/linuxbrew/bin/brew shellenv)
  fi
fi

[ -f ~/.dotfiles/secrets ] && source ~/.dotfiles/secrets
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
[ -f ~/.asdf/completions/asdf.bash ] && source ~/.asdf/completions/asdf.bash

alias ovim=$HOMEBREW_PREFIX/bin/vim

alias :q="exit"
alias :r="ruby"
alias :n="node"
alias :p="python"
alias k="kubectl"
alias kx="kubectx"
alias yolo="sudo \$(history | tail -1 | awk \"{\\\$1 = \\\"\\\"; print \\\$0}\")"
alias vu="vim +PlugUpdate +qa"
alias buvu="bu && vu"
alias kk="cd ~/Codez/kubernetes"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

ssh-add -l &>/dev/null
if [[ $? == 1 ]]; then
  ssh-add &>/dev/null
fi

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # exec tmux
# fi

# make sure return code is 0
true
