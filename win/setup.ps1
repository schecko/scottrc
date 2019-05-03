
param (
	[string]$type = ""
)

function clean() {
	echo "Removing old installation"

	rm -r -force ~/.config/nvim/
	rm -r -force ~/.config/i3/
	rm -force ~/.config/gitrc
	rm -force ~/.gitconfig
	rm -force ~/.vimrc
	rm -force ~/.bashrc
	if(test-path "~/AppData/Local/nvim") {
		rmdir -force "~/AppData/Local/nvim"
	}
}

function baseInstall($source) {
	echo "Copying dotfiles"

	cp -r -force $source/home/* ~/
}

function configureNeovim() {
	echo "Configuring vim"

	mkdir -p ~/.config/nvim/plugged/youcompleteme

	cmd /c mklink /d "~/.config/nvim" "~/AppData/Local/nvim"

	$PLUG_FILE="~/.config/nvim/autoload/plug.vim"
	new-item -force $PLUG_FILE
	curl -uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -outfile $PLUG_FILE
	pip install --upgrade neovim
	nvim +'PlugInstall --sync' +qa
	pushd ~/.config/nvim/plugged/youcompleteme
		python install.py --clang-completer
	popd
}

rm -force "~/.bash_profile"
new-item -itemtype SymbolicLink -Name "~\.bash_profile" -Target "~\.bashrc"
#cmd /c mklink "~/.bash_profile" "~/.bashrc"

if ($type -eq "full") {
	clean
	baseInstall ..
	configureNeovim
} else {
	baseInstall D:/src/scottrc
}
