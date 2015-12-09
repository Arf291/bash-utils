# !/bin/bash

function main() {
	dir="."

	if [ $# -gt 0]; then
		dir="$1"
	fi

	bats $dir/tests/*.bats
}

main "$@"