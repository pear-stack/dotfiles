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
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if command -v nvim &> /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi

if command -v w3m &> /dev/null; then
  function ddgs { w3m "https://duckduckgo.com/lite?q=$*"; }
  alias '?'='ddgs'
fi

if command -v gemini &> /dev/null; then
  export GEMINI_SYSTEM_MD="$HOME/.gemini/system.md"
  function gs { gemini "$*" | glow - }
  alias '??'='gs'
fi

if command -v fzf &> /dev/null && command -v rg &> /dev/null && command -v zoxide &> /dev/null && command -v bat &> /dev/null; then
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

  function fs {
    RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
    fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
  }

  function fd {
    local dir=$(
      zoxide query --list --score |
      fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
    ) && cd "$dir"
  }
fi

if command -v eza &> /dev/null; then
  alias ls='eza --icons --color'
  alias lsa='eza -lh --group-directories-first --icons=auto --git'
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
unalias zi 2>/dev/null
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

