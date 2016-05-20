#! /bin/bash
#
# vim-prepare-env.sh
# Copyright (C) 2016 witcher <witcher@MaciejPlachta>
#
# Distributed under terms of the MIT license.
#
create_directory(){
	local path_to_directory=$1;
	if [ -d ${path_to_directory} ]; then
		echo "${path_to_directory} directory exists";
	else
		echo "creating directory: ${path_to_directory}";
		mkdir -p ${path_to_directory};
	fi
}

set_up_vundle(){
	local bundle_dir="$1/bundle"
	create_directory ~/.vim/bundle
	echo "installing Vundle to a ${bundle_dir}"
	git clone https://github.com/VundleVim/Vundle.vim.git ${bundle_dir}/Vundle.vim
}

download_powerline_fonts(){
	echo "downloading sources for powerline fonts from https://github.com/powerline/fonts"
	git clone https://github.com/powerline/fonts $1/powerline.source
}

install_powerline_fonts(){
	echo "installing powerline fonts"
	pushd $1/powerline.source && ./install.sh
	popd
	echo "removing of a powerline sources"
	rm -rf $1/powerline.source
}

set_up_powerline_fonts(){
	local current_dir=$1
	download_powerline_fonts ${current_dir}
	install_powerline_fonts ${current_dir}
}

set_up_vundle ~/.vim
set_up_powerline_fonts `pwd`
