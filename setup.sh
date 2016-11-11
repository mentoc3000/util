#!/bin/bash

echo "---Creating links---"

# files that we want to create links for
files=(.bashrc .bash_profile .bash_logout .gitconfig .vimrc)

# directory of the script
utildir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# iterate over files
for file in "${files[@]}"
do
	linkpath="$HOME/$file"
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

echo "---Downloading vim packages---"


# Download Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
if [ -a ~/.vim/autoload/pathogen.vim ]
then
   echo "Pathogen is already installed"
else
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
   echo "Pathogen installed"
fi

# Download Solarized
if [ -a ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ]
then
   echo "Solarized is already installed"
else
   cd ~/.vim/bundle
   git clone git://github.com/altercation/vim-colors-solarized.git
   echo "Solarized installed"
fi

# Download Syntastic
if [ -a ~/.vim/bundle/syntastic/plugin/syntastic.vim ]
then
   echo "Syntastic is already installed"
else
   cd ~/.vim/bundle
   git clone --depth=1 https://github.com/scrooloose/syntastic.git
   echo "Syntastic installed"
fi

# Downlaod vim-javascript
if [ -a ~/.vim/bundle/vim-javascript/ftplugin/javascript.vim ]
then
   echo "vim-javascript is already installed"
else
   git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
   echo "vim-javascript installed"
fi

