#!/usr/bin/env bats

@test "no matched files" {
	echo "Hello world" > match/tests/test1/hello.txt
	bash match/match.sh match/tests/test1/ match/tests/test2/

	result=$(ls -l result/ | wc -l)
	[ $result -eq 0 ]
}

@test "one matched file" {
	echo "Hello world!" > match/tests/test1/hello.txt
	bash match/match.sh match/tests/test1/ match/tests/test2/

	result=$(ls -l result/ | wc -l)
	((result-=1))
	[ $result -eq 1 ]
}