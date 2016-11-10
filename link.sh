#!/bin/bash

# files that we want to create links for
files=(.bashrc .bash_profile .bash_logout .gitconfig .vimrc)

# directory of the script
utildir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
homedir="$( cd && pwd)"

# iterate over files
for file in "${files[@]}"
do
	linkpath="$homedir/$file"
	filepath="$utildir/$file"
	# if the link file exists already
	if [ -a $linkpath ]
	then
		# if the link file is a symbolic link
		if [ -L $linkpath ]
		then
			if ln -sfn $filepath $linkpath
			then
				echo "$file link has been updated to $filepath"
			fi
		# if the link file is a normal file
		elif [ -f $linkpath ]
		then
			numVersions=$(ls -alF ~ | grep $file | wc -l)
			file_old="${linkpath}_old${numVersions}"
			mv $linkpath $file_old
			if ln -s $filepath $linkpath
			then
				echo "$file has been renamed to $file_old and link created to $filepath"
			fi
		fi
	# if there is no file or link is broken
	else
		if ln -sfn $filepath $linkpath
		then
			echo "$file link has been created to $filepath"
		fi
	fi
done

