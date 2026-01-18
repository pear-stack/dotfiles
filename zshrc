ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# History
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt complete_aliases

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Aliases
alias work="tmuxp load ~/.config/tmux/work.yaml"
alias home="tmuxp load ~/.config/tmux/base.yaml"

alias vi='nvim'
alias vim='nvim'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

function ddgs { w3m "https://duckduckgo.com/lite?q=$*"; }
function gs {
    gemini "$*" | glow -
}
alias '?'='ddgs'
alias '??'='gs'

export GEMINI_SYSTEM_MD="$HOME/.gemini/system.md"

if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto --git'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

PATH="$HOME/.local/bin:$PATH"

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

