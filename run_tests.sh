# !/bin/bash

function main() {
	dir="."

	if test $# -gt 0; then
		dir=$1
	fi

	bats $dir/tests/*.bats
}

main "$@"