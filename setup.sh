#!/bin/bash
if [ ! -z `which zsh` ]; then
    echo "Changing shell to zsh (ctrl c if you aren't a sudoer)"
    sudo chsh -s $(which zsh)
else
    echo "Zsh not installed, do that first"
    exit
fi

git clone https://github.com/wumb0/dotfiles-new
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp dotfiles-new/.??* ~
git clone https://github.com/oskarkrawczyk/honukai-iterm-zsh
cp honukai-iterm-zsh/honukai.zsh-theme ~/.oh-my-zsh/custom/themes
rm -rf honukai-iterm-zsh dotfiles-new

echo "Done, launch vim to install bundles, configure plugins for oh my zsh in .zshrc"
