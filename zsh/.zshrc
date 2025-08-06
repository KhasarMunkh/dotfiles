# --- Powerlevel10k instant prompt (keep at top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Extra completions *before* Oh My Zsh is sourced ---
fpath+=("${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions/src")
# (no manual compinit – OMZ will handle it)

# --- Oh My Zsh core ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

# --- Powerlevel10k configuration ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- NVM lazy-load helper ---
if [[ $- == *i* ]]; then
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh"        ]] && . "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
fi
