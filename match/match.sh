# !/bin/bash

# Match no common files between two directories taken by their hash.
# It copies no common files in the first directory, compared to the second one.
# Usage: match.sh folder-to-check folder-to-compare [destination-folder]
#	- 1: first directory to match
#	- 2: second directory to match
#

function getCommand() {
	command="md5sum"

	if [ "$(uname)" = "Darwin" ]; then
		command="md5 -r"
	fi
}

function main() {
	ext="*"
	dest="result/"

	if [ $# -lt 2 ];  then
		echo  "Usage: match.sh folder-to-check folder-to-compare [destination-folder]"
		exit
	elif 	[ "$#" = 3 ];  then
		dest=$3
	fi

	getCommand command

	dir1=$1
	dir2=$2
	files1=$(find $dir1 -type f )
	files2=$(find $dir2 -type f )
	count=0
	times=0

	mkdir -p $dest

	if  [ "$(ls -A $dest)" ]; then
		rm $dest/*	
	fi

	echo "Matching..."
	for file1 in $files1; do
		md5=$($command $file1 | cut -d ' ' -f 1)
		times=0
		
		for file2 in $files2; do		
			md5n=$($command $file2 | cut -d ' ' -f 1)		
			
			if [ $md5 = $md5n ]; then
				((times++))
				break
			fi
		done
		
		if [ $times = 0 ]; then
			cp $file1 $dest
			times=0
		fi
		
	done

	count=$(ls -l $dest | wc -l)

	if [ $count -gt 0 ]; then
		((count-=1))
	fi

	echo "$count files filtered"

}

main "$@"