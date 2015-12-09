#!/usr/bin/env bats

@test "no matched file" {
	echo "Hello world" > tests/test1/hello.txt
	bash match.sh tests/test1/ tests/test2/

	result=$(ls -l result/ | wc -l)
	[ $result -eq 0 ]
}

@test "one matched file" {
	echo "Hello world!" > tests/test1/hello.txt
	bash match.sh tests/test1/ tests/test2/

	result=$(ls -l result/ | wc -l)
	((result-=1))
	[ $result -eq 1 ]
}