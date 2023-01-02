
function touch($file) {
	"" | Out-File $file -Encoding ASCII
}

function grep($regex, $dir) {
	if ( $dir ) {
		ls $dir | select-string $regex
		return
	}
	$input | select-string $regex
}

function export($name, $value) {
	set-item -force -path "env:$name" -value $value;
}

function c {
	& "cargo" @Args
}

function cr {
	& "cargo" "run" @Args
}

function crr {
	& "cargo" "run" "--release" @Args
}

function cb {
	& "cargo" "build" @Args
}
