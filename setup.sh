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
   echo "Pathogen is already installed (https://github.com/tpope/vim-pathogen)"
else
   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
   echo "Pathogen installed (https://github.com/tpope/vim-pathogen)"
fi

# Download Solarized
if [ -a ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ]
then
   echo "Solarized is already installed (https://github.com/altercation/vim-colors-solarized)"
else
   cd ~/.vim/bundle
   git clone git://github.com/altercation/vim-colors-solarized.git
   echo "Solarized installed (https://github.com/altercation/vim-colors-solarized)"
fi

# Download Syntastic
if [ -a ~/.vim/bundle/syntastic/plugin/syntastic.vim ]
then
   echo "Syntastic is already installed (https://github.com/vim-syntastic/syntastic)"
else
   cd ~/.vim/bundle
   git clone --depth=1 https://github.com/scrooloose/syntastic.git
   echo "Syntastic installed (https://github.com/vim-syntastic/syntastic)"
fi

# Download vim-javascript-syntax
if [ -a ~/.vim/bundle/vim-javascript-syntax/syntax/javascript.vim ]
then
   echo "vim-javascript-syntax is already installed (https://github.com/jelera/vim-javascript-syntax)"
else
   git clone https://github.com/jelera/vim-javascript-syntax.git ~/.vim/bundle/vim-javascript-syntax
   echo "vim-javascript-syntax installed (https://github.com/jelera/vim-javascript-syntax)"
fi

# Download vim-javascript
if [ -a ~/.vim/bundle/vim-javascript/syntax/javascript.vim ]
then
   echo "vim-javascript is already installed (https://github.com/pangloss/vim-javascript)"
else
   git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
   echo "vim-javascript installed (https://github.com/pangloss/vim-javascript)"
fi

# Download vim-signature
if [ -a ~/.vim/bundle/vim-signature/plugin/signature.vim ]
then
   echo "vim-signature is already installed (https://github.com/kshenoy/vim-signature)"
else
   git clone https://github.com/kshenoy/vim-signature.git ~/.vim/bundle/vim-signature
   echo "vim-signature installed (https://github.com/kshenoy/vim-signature)"
fi

# Download Surround
if [ -a ~/.vim/bundle/vim-surround/plugin/surround.vim ]
then
   echo "vim-surround is already installed (https://github.com/tpope/vim-surround)"
else
   cd ~/.vim/bundle
   git clone git://github.com/tpope/vim-surround.git
   echo "vi-surround installed (https://github.com/tpope/vim-surround)"
fi

# Download Supertab
if [ -a ~/.vim/bundle/supertab/plugin/supertab.vim ]
then
   echo "Supertab is already installed (https://github.com/ervandew/supertab)"
else
   cd ~/.vim/bundle
   git clone https://github.com/ervandew/supertab.git
   echo "Supertab installed (https://github.com/ervandew/supertab)"
fi

# Download NERDtree
if [ -a ~/.vim/bundle/nerdtree/autoload/nerdtree.vim ]
then
   echo "NERDtree is already installed (https://github.com/scrooloose/nerdtree)"
else 
   git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
   echo "NERDtree installed (https://github.com/scrooloose/nerdtree)"
fi

# Download NERDcommenter
if [ -a ~/.vim/bundle/nerdcommenter/plugin/NERD_commenter.vim ]
then
   echo "NERDcommenter is already installed (https://github.com/scrooloose/nerdcommenter)"
else
   cd ~/.vim/bundle
   git clone https://github.com/scrooloose/nerdcommenter.git
   echo "NERDcommenter installed (https://github.com/scrooloose/nerdcommenter)"
fi

## Download Powerline
#if [ -a ~/.vim/bundle/powerline/setup.py ]
#then
#   echo "Powerline is already installed (https://github.com/powerline/powerline)"
#else
#   # make sure python is installed
#   python_ok=$(dpkg-query -W --showformat='${Status}\n' python|grep "install ok installed")
#   if [ "" == "$python_ok" ]
#   then
#      echo "Python is required.  Installing..."
#      sudo apt-get -y install python
#   fi
#
#   #make sure pip is installed
#   pip_ok=$(dpkg-query -W --showformat='${Status}\n' python-pip|grep "install ok installed")
#   if [ "" == "$pip_ok" ]
#   then
#      echo "pip is required.  Installing..."
#      sudo apt-get install python-pip
#   fi
#
#   pip install powerline-status
#   echo "Powerline installed (https://github.com/powerline/powerline)"
#fi
#
#
## Download vim-airline
#if [ -a ~/.vim/bundle/vim-airline/plugin/airline.vim ]
#then
#   echo "Airline is already installed (https://github.com/vim-airline/vim-airline)"
#else
#   git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
#   echo "Airline installed (https://github.com/vim-airline/vim-airline)"
#fi
#
## Download powerline fonts
#if [ -a ~/.vim/bundle/powerline-fonts/install.sh ]
#then
#   echo "Powerline Fonts is already installed (https://github.com/powerline/fonts)"
#else
#   git clone https://github.com/powerline/fonts.git ~/.vim/bundle/powerline-fonts
#   bash ~/.vim/bundle/powerline-fonts/install.sh
#   echo "Powerline Fonts installed (https://github.com/powerline/fonts)"
#fi
#
## Download airline themes
#if [ -a ~/.vim/bundle/vim-airline-themes/plugin/airline-themes.vim ]
#then
#   echo "Airline Themes is already installed (https://github.com/vim-airline/vim-airline-themes)"
#else
#   git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
#   echo "Airline Themes installed (https://github.com/vim-airline/vim-airline-themes)"
#fi


# Download Lightline
if [ -a ~/.vim/bundle/lightline.vim/plugin/lightline.vim ]
then
   echo "Lightline is already installed (https://github.com/itchyny/lightline.vim)"
else
   git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
   echo "Lightline installed (https://github.com/itchyny/lightline.vim)"
fi

# Download Fugitive
if [ -a ~/.vim/bundle/vim-fugitive/plugin/fugitive.vim ]
then
   echo "Fugitive is already installed (https://github.com/tpope/vim-fugitive)"
else
   cd ~/.vim/bundle
   git clone git://github.com/tpope/vim-fugitive.git
   vim -u NONE -c "helptags vim-fugitive/doc" -c q
   echo "Fugitive installed (https://github.com/tpope/vim-fugitive)"
fi
