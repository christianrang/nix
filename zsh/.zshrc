# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/mongodb/bin:$PATH
export PATH=$HOME/.asdf/installs/rust/1.74.0/bin:$PATH
export PATH=$HOME/.usr/local/bin:$PATH

set -o vi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    zsh-autosuggestions
    golang
    z
    docker
    kubectl
    python
    react-native
    terraform
    helm
    fzf
)

source $ZSH/oh-my-zsh.sh

alias ll="ls -l"
alias cat="bat"
alias t="tmux"
# Neovim
alias vim="nvim"
export EDITOR="nvim"
alias k=kubectl
source <(kubectl completion zsh)
alias kctx=kubectx
alias kns=kubens

alias tyrd='tmux neww -c "#{pane_current_path}" "yarn run dev"'
alias tgrm='tmux neww -c "#{pane_current_path}" "go run ./cmd/*/main.go && sleep 10"'
alias tdbg='tmux neww -c "#{pane_current_path}" "/home/crang/.asdf/installs/golang/1.20.7/packages/bin/dlv debug ./cmd/*/main.go && sleep 10"'
alias tw='tmux neww -c "#{pane_current_path}"'

alias glow="glow -p"

export PROGDEV="$HOME/progdev"
export GITHUBPATH="$PROGDEV/github.com"
export CRGHPATH="$GITHUBPATH/christianrang"
export NOTES="$HOME/notes/"

export DEVPATHS="/home/crang/progdev/github.com/christianrang /home/crang/progdev/gitlab.rang-corp.com/crang /home/crang/progdev/github.com/fastly /home/crang/Documents/projects"

export GOPATH="$PROGDEV/go"
export PATH="$PATH:$GOPATH/bin"

. "$HOME/.asdf/asdf.sh"

# Source other RC's depending on system I'm using
# for WSL
if [ -f ~/.wslrc ]; then source ~/.wslrc; fi
if [ -f ~/.linuxrc ]; then source ~/.linuxrc; fi
if [ -f ~/.macrc ]; then source ~/.macrc; fi

if [ ! -d $PROGDEV ]; then mkdir -p $PROGDEV; fi
if [ ! -d $GITHUBPATH ]; then mkdir -p $GITHUBPATH; fi
if [ ! -d $CRGHPATH ]; then mkdir -p $CRGHPATH; fi
if [ ! -d $NOTES ]; then mkdir -p $NOTES; fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then 
    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.asdf ]; then 
    git clone --quiet https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export CHEAT_USE_FZF=true

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# alias mods="OPENAI_API_KEY=$(pass show openai/api_key) mods"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
