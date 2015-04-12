ZSH=$HOME/.oh-my-zsh
ZSH_THEME="$ZSH_CUSTOM/themes/eddiezane"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
plugins=(git eddiezane go npm)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh
unsetopt auto_name_dirs

if [[ `uname` == "Darwin" ]]; then
  if [ -z "$TMUX" ]; then
    export BROWSER=open
    export EDITOR=vim
    export GOROOT=/usr/local/opt/go/libexec
    export GOPATH=/Users/eddiezane/Codez/GOPATH
    export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export NVM_DIR=~/.nvm
  fi
  source ~/.dotfiles/API_KEYS
  source $(brew --prefix nvm)/nvm.sh
  source $(brew --prefix php-version)/php-version.sh && php-version 5
  source /usr/local/share/zsh/site-functions/nvm_bash_completion
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
  if which jenv > /dev/null; then eval "$(jenv init -)"; fi
else
  export PATH=$HOME/.rbenv/bin:/usr/local/go/bin:$PATH
fi

alias :q="exit"
alias :r="ruby"
alias :n="node"
alias :p="python"
alias pypi-deploy="python setup.py sdist bdist_wininst upload"
alias yolo="sudo \$(history | tail -1 | awk \"{\\\$1 = \\\"\\\"; print \\\$0}\")"
alias bu="brew update && brew upgrade"
alias vu="vim +PluginUpdate +qa"

function mkcd {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

function name_dat_tmux {
if [ "$TMUX" ]; then
  if [ "$PWD" != "$OLDPWD" ]; then
    OLDPWD="$PWD";
    tmux rename-window ${PWD##*/};
  fi
fi
}

precmd_functions+='name_dat_tmux'

function ssh {
  if [[ $# == 0 || -z $TMUX ]]; then
    command ssh $@
    return
  fi
  local remote=${${(P)#}#*@*}
  local old_name="$(tmux display-message -p '#W')"
  local renamed=0
  if [[ $remote != -* ]]; then
    renamed=1
    tmux rename-window $remote
  fi
  command ssh $@
  if [[ $renamed == 1 ]]; then
    tmux rename-window "$old_name"
  fi
}

function chrome {
  open -a /Applications/Google\ Chrome.app $@
}

ssh-add -l &>/dev/null
if [[ $? == 1 ]]; then
  ssh-add &>/dev/null
fi

# make sure return code is 0
true
