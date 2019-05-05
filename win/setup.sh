#!/bin/bash
# enable windows symlinks, otherwise ln is just an alias of cp. useless.
export MSYS=winsymlinks:nativestrict

function clean() {
	echo "Removing old installation"

	rm -r -f ~/.config/nvim/
	rm -r -f ~/.config/i3/
	rm -f ~/.config/gitrc
	rm -f ~/.gitconfig
	rm -f ~/.vimrc
	rm -f ~/.bashrc
	rm -f ~/.bash_profile
}

function baseInstall() {
	echo "Copying dotfiles"
	SOURCE=$1


	shopt -s dotglob
	cp -rf $SOURCE/home/* ~/
	shopt -u dotglob

	# explicitly delete the old profile, on debian
	# it should point to .profile
	rm -f ~/.bash_profile
	ln -s ~/.bashrc ~/.bash_profile
	# git bash can't handle windows symlinks.
	# don't do this:
	#	cmd /c mklink "~/.bash_profile" "~/.bashrc"
}

function configureNeovim() {
	echo "Configuring vim"

	rm -f ~/AppData/Local/nvim
	mkdir -p ~/.config/nvim/plugged/youcompleteme

	ln -sd "$HOME/.config/nvim/" "$HOME/AppData/Local/"

	curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1
	pip install --upgrade neovim
	# make sure nvim runs headless, msys is not a supported tty
	nvim --headless +'PlugInstall --sync' +qa
	pushd ~/.config/nvim/plugged/youcompleteme
		python install.py --clang-completer
	popd
}

if [[ $1 == "full" ]]; then
	clean
	baseInstall ..
	configureNeovim
elif [[ $1 == "clean" ]]; then
	clean
else
	# expects scottrc to be located here,
	# allows quick to be executed from anywhere
	baseInstall D:/src/scottrc
fi
