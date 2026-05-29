#!/usr/bin/env bash
set -e

# ---- Package manager detection ----
detect_pm() {
  if   command -v apt &>/dev/null; then
    PM="apt";        INSTALL="apt install -y";            UPDATE="apt update"
  elif command -v pacman &>/dev/null; then
    PM="pacman";     INSTALL="pacman -S --noconfirm";     UPDATE="pacman -Sy"
  elif command -v dnf &>/dev/null; then
    PM="dnf";        INSTALL="dnf install -y";            UPDATE="dnf check-update"
  elif command -v pkg &>/dev/null; then
    PM="pkg";        INSTALL="pkg install -y";            UPDATE="pkg update"
  elif command -v brew &>/dev/null; then
    PM="brew";       INSTALL="brew install";              UPDATE="brew update"
  else
    echo "Unknown package manager"; exit 1
  fi
}

detect_pm

echo "==> Installing dependencies..."
$UPDATE
$INSTALL zsh git curl wget vim tmux fzf stow which

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Installing ZSH plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k" 2>/dev/null || true
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  git clone "https://github.com/zsh-users/$plugin" \
    "$ZSH_CUSTOM/plugins/$plugin" 2>/dev/null || true
done

echo "==> Installing vim-plug..."
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -E -s -u "$PWD/vim/.vimrc" +PlugInstall +qall 2>/dev/null || true

echo "==> Installing TPM..."
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" 2>/dev/null || true
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true

echo "==> Removing old configs that would conflict with stow..."
rm -f "$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.vimrc" "$HOME/.gitconfig"
rm -rf "$HOME/.config/opencode"

echo "==> Creating ~/.config..."
mkdir -p "$HOME/.config"

echo "==> Stowing dotfiles..."
stow */

echo "Done!"
