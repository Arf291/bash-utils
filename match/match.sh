# !/bin/bash

# Match no common files between two directories taken by their hash
#	- 1: first directory to match
#	- 2: second directory to match
#


ext="*"
dest="result/"

if [ $# -lt 2 ];  then
	echo  "Usage: match.sh folder-to-check folder-to-compare destination-folder"
	exit
elif 	[ "$#" = 3 ];  then
	dest=$3
fi

dir1=$1
dir2=$2
files1=$(find $dir1 -type f )
files2=$(find $dir2 -type f )
count=0
temp=0

comm="md5sum"

if [ "$(uname)" = "Darwin" ]; then
	comm="md5 -r"
fi

if  [ "$(ls -A $dest)" ]; then
	rm $dest/*	
else
	mkdir -p $dest
fi

echo "Matching..."
for file1 in $files1; do
	md5=$($comm $file1 | cut -d ' ' -f 1)
	temp=0
	
	for file2 in $files2; do		
		md5n=$($comm $file2 | cut -d ' ' -f 1)		
		
		if [ $md5 = $md5n ]; then
			((temp++))
			break
		fi
	done
	
	if [ $temp = 0 ]; then
		cp $file1 $dest
		temp=0
	fi
	
done

count=$(ls -l $dest | wc -l)

if [ $count -gt 0 ]; then
	((count-=1))
fi

echo "$count files filtered"
