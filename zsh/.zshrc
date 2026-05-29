# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=${DEVKITPRO}/devkitARM
export DEVKITPPC=${DEVKITPRO}/devkitPPC
export PATH=${DEVKITPRO}/tools/bin:$PATH
# GITHUB_TOKEN="your_token_here"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  aliases
  z
  extract
  zsh-syntax-highlighting
  zsh-autosuggestions
  history-substring-search
  man
  tmux
)

source $ZSH/oh-my-zsh.sh

alias v="vim"
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias xct='exit'
alias clr='clear'
alias cls='clear'

command -v lsd &>/dev/null && alias lt='lsd --tree'
command -v htop &>/dev/null && alias h="htop"

export TERM=xterm-256color

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# opencode
export PATH=/root/.opencode/bin:$PATH

# pnpm
export PNPM_HOME="/root/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
