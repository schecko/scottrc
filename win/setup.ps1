
function deleteExists($path) {
	if (test-path $path) {
		remove-item -Force $path
	}
}

function deleteFolderExists($path) {
	if (test-path $path) {
		remove-item -Recurse $path
	}
}

function clean() {
	deleteFolderExists ~/.config/nvim/*
	deleteFolderExists ~/.config/i3/*
	deleteExists ~/.config/gitrc
	deleteExists ~/.gitconfig
	deleteExists ~/.vimrc
	deleteExists $profile
}

function baseInstall($SOURCE) {
	copy-item -Force -Recurse -Path $SOURCE/home/* -Destination ~/
	copy-item -Path $SOURCE/home/profile.ps1 -Destination $profile
}

clean
baseInstall ..
