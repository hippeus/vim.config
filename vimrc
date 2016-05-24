" Sample .vimrc file by Martin Brochhaus
" Presented at PyCon APAC 2012


" ============================================
" Note to myself:
" DO NOT USE <C-z> FOR SAVING WHEN PRESENTING!
" ============================================


" Automatic reloading of .vimrc
"" autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
""set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Syntax highlighting enables Vim to show parts of the text in another font or
" color
syntax enable

" support for autoread/autoreaload file
" auto-read won't happen if you do nothing some action must occur for details
" see http://www.mail-archive.com/vim@vim.org/msg05900.html
set autoread
:map <F7> :checktime<CR>
:map! <F7> <C-O>:checktime<CR>,,

" this enables/disable "visual" wrapping
set wrap
" set nowrap

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
"" map <c-j> <c-w>j
"" map <c-k> <c-w>k
"" map <c-l> <c-w>l
"" map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>

" nerd tree mapping
" remap <ESC> key
nmap <leader>ne :NERDTree<cr>
map <leader>` <ESC>
map! <leader>` <ESC>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=120
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
"expandtabs turn of TAB's as TAB's
"set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
"" set nobackup
"" set nowritebackup
"" set noswapfile

" ============================================================================
" Vundle Setup
" ============================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-sleuth'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" NOTE: install Plugins:
" Launch vim and run :PluginInstall

" ============================================================================
" YouCompleteMe configuration
" ============================================================================
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_whitelist = {
      \ 'cpp': 1,
      \ 'python' : 1,
      \ 'go' : 1
	\}
let g:ycm_error_symbol = '*'
map <silent> gd :YcmCompleter GoToDeclaration<CR>
map <silent> gf :YcmCompleter GoToDefinition<CR>

" ============================================================================
" Python IDE Setup
" ============================================================================
" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
"" let g:jedi#usages_command = "<leader>z"
"" let g:jedi#popup_on_dot = 0
"" let g:jedi#popup_select_first = 0
"" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"" set completeopt=longest,menuone
"" function! OmniPopup(action)
""     if pumvisible()
""         if a:action == 'j'
""             return "\<C-N>"
""         elseif a:action == 'k'
""             return "\<C-P>"
""         endif
""     endif
""     return a:action
"" endfunction

"" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
"" set nofoldenable

" ============================================================================
" Airline configuration - fancy powerline (status bar at buttom of the window)
" ============================================================================
set laststatus=2   " Always show the statusline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'murmur'


" ============================================================================
" Vim-gutter configuration - shows a git diff in a sign column
" ============================================================================
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

map <C-Down> :bprevious<CR>
map <C-Up> :bnext<CR>

let excluded_files=""
map <F4> :execute "silent lgrep! -srnw --binary-files=without-match --exclude-dir=.git --exclude="excluded_files" . -e " . expand("<cword>") . " " <bar> lopen 33<CR>

map <C-t> :NERDTree .<CR>
map <S-t> :TagbarToggle<CR>

" Ctags configuration
set tags=~/.vim/current_tags
command Ctags execute "!ctags -R --tag-relative=yes --exclude=\".git|build\" -f "&tags"."
nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
