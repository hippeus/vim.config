#! /bin/bash
#
# vim-prepare-env.sh
# Copyright (C) 2016 witcher <witcher@MaciejPlachta>
#
# Distributed under terms of the MIT license.
#

source ./inc/colors.inc

youCompleteMeDir="$HOME/.vim/bundle/YouCompleteMe"

create_directory(){
	local path_to_directory=$1;
	if [ -d ${path_to_directory} ]; then
		echo -e "[${CYAN}INFO${RESTORE}] Directory ${path_to_directory} exists";
	else
		echo -e "[${CYAN}INFO${RESTORE}] Creating directory: ${path_to_directory}";
		mkdir -p ${path_to_directory};
	fi
}

set_up_vundle(){
	local bundle_dir="$1/bundle"
	create_directory ~/.vim/bundle
	echo -e "[${CYAN}INFO${RESTORE}] Installing Vundle to a ${bundle_dir}"
	git clone https://github.com/VundleVim/Vundle.vim.git ${bundle_dir}/Vundle.vim
}

download_powerline_fonts(){
	echo -e "[${CYAN}INFO${RESTORE}] Downloading sources for powerline fonts from https://github.com/powerline/fonts"
	git clone https://github.com/powerline/fonts $1/powerline.source
}

install_powerline_fonts(){
	echo -e "[${CYAN}INFO${RESTORE}] Installing powerline fonts"
	pushd $1/powerline.source && ./install.sh
	popd
	echo -e "[${CYAN}INFO${RESTORE}] Removing of a powerline sources"
	rm -rf $1/powerline.source
}

set_up_powerline_fonts(){
	local current_dir=$1
	download_powerline_fonts ${current_dir}
	install_powerline_fonts ${current_dir}
}

install_vim_plugins(){
	vim +PluginInstall +qall
}

compile_you_complete_me(){
	local goSupport="--gocode-completer"
	local cFamilySupport="--clang-completer"

	pushd ${youCompleteMeDir}
	echo -e "[${CYAN}INFO${RESTORE}] Changing directory to ${youCompleteMeDir}"
	./install.py ${cFamilySupport} ${goSupport}
	popd
	echo -e `pwd`
}

install_ycm_pre_requirements(){
	sudo apt-get install build-essential cmake
	sudo apt-get install python-dev python3-dev
	sudo apt-get install golang
	sudo apt-get install ninja-build
}

install_ycm_extra_conf(){
	local ycmCPPConfigFile="ycm_extra_conf.py"
	if [ -e ${ycmCPPConfigFile} ]; then
		create_directory ${youCompleteMeDir}/ycm_config_c++_skeleton
		cp ${ycmCPPConfigFile} ${youCompleteMeDir}/ycm_config_c++_skeleton/
	else
		echo -e "[${CYAN}INFO${RESTORE}] Omitting: install ycm_extra_conf.py"
	fi
}

install_you_complite_me(){
	install_ycm_pre_requirements
	compile_you_complete_me
	install_ycm_extra_conf
}

install_vim(){
	sudo apt-get install vim-gnome
	local vimrc="vimrc"
	cp ${vimrc} ${HOME}/.${vimrc}
}

install_vim
set_up_vundle ~/.vim
set_up_powerline_fonts `pwd`
install_vim_plugins
install_you_complite_me
echo -e $?
