# Pager for man
export PAGER=less
export MANPAGER='less -R'
# nice defaults for less
export LESS='-R -M -g -i -J -w'
export LESSHISTFILE=-

# IMPORTANT: if MANPATH is set, it *overrides* defaults. Usually best to unset.
unset MANPATH

# --- Powerlevel10k instant prompt (keep at very top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Oh My Zsh core ---
export ZSH="$HOME/.oh-my-zsh"

# Speed up completion
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$ZSH_VERSION"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Keep plugins lean (drop OMZ fzf plugin; we’ll use system fzf)
plugins=(git man colored-man-pages zsh-autosuggestions)

# If you had a custom zsh-completions plugin on disk, you can keep this.
# Otherwise you can delete the fpath line.
# fpath+=("${ZSH_CUSTOM:-$HOME/.oh-my-zsh}/custom/plugins/zsh-completions/src")

source "$ZSH/oh-my-zsh.sh"

# --- System fzf bindings (lighter than OMZ's fzf plugin) ---
if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [[ -r /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

# --- Editor ---
export EDITOR="nvim"

# --- Powerlevel10k configuration ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- NVM (load Node LTS by default) ---
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"


# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh
# [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:/home/kmunkh/.dotnet/tools"

# Use vi keybindings in zsh (insert/normal modes like Vim)
bindkey -v

# Faster ESC to switch to normal mode (in ms)
export KEYTIMEOUT=1

# 'v' in normal mode edits the current command in $EDITOR (handy!)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line


tmux_sessionizer_widget() { tmux-sessionizer; zle reset-prompt }
zle -N tmux_sessionizer_widget
bindkey -M viins '^F' tmux_sessionizer_widget
