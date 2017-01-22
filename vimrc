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
noremap <Leader>n :nohl<CR>
vnoremap <Leader>n :nohl<CR>
inoremap <Leader>n :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
" Every unnecessary keystroke that can be saved is good for your health :)
map <A-j> <c-w>j
map <A-k> <c-w>k
map <A-l> <c-w>l
map <A-h> <c-w>h
"
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
"
map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>

" easier navigation between tabs
map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>

" easier navigation between buffers
map <C-Down> :bprevious<CR>
map <C-Up> :bnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" remap <ESC> key
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
set tw=120   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=140
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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips' " Ultimate Snippet manager (engine)
Plugin 'honza/vim-snippets' " Snippets for ultisnips
Plugin 'AndrewRadev/splitjoin.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Syntax highlighting enables Vim to show parts of the text in another font or
" color
syntax enable		    " required

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
let g:ycm_collect_identifiers_from_tags_files = 1
map <silent> gd :YcmCompleter GoToDeclaration<CR>
map <silent> gf :YcmCompleter GoToDefinition<CR>
map <silent> gi :YcmCompleter GoToInclude<CR>

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
" ]c jump to the next hunk
" [c jump to the previous hunk
" <leader>hp preview
" <leader>hs stage
" <leader>hu undo

" ============================================================================
" Settings for ctrlp
" ============================================================================
" cd ~/.vim/bundle
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" grep bindings
let excluded_files=""
map <F4> :execute "silent lgrep! -srnw --binary-files=without-match --exclude-dir=.git --exclude="excluded_files" . -e " . expand("<cword>") . " " <bar> lopen 33<CR>

" ============================================================================
" NERDTree configuration
" ============================================================================
map <C-t> :NERDTree .<CR>
map <S-t> :TagbarToggle<CR>

" When you <S-t> on some entry in a NerdTree window it will open in a new window
" which will be placed it tap just after current window, this function substitute
" default setting to place new tab at the end of windows queue.
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

" ============================================================================
" Ctags configuration
" ============================================================================
set tags=~/.vim/current_tags
command Ctags execute "!ctags -R --tag-relative=yes --exclude=\".git|build\" -f "&tags"."
nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>

" ============================================================================
" UltiSnips configuration
" ============================================================================
" Make UltiSnips compatible with the YCM by picking snippet from context menu
" with the Return key
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
	return snippet
    else
	return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
" ============================================================================
" Golang configuration
" ============================================================================
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" mapping to navigate through compile errors
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" sets golang "formater" to goimports which handles missing packages and fix syntax
let g:go_fmt_command = "goimports"

" enable enhanced highlights for go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" useful shortcuts
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')  " runs :GoAlternate
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit') " opens a new vertical split with the alternate file
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split') " opens a new horizontal split with the alternate file
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe') " the same but opens file in a new tab

autocmd FileType go nmap <Leader>i <Plug>(go-info) " execute :GoInfo which prints func signature in a status line
let g:go_auto_type_info = 1 " automatically runs :GoInfo for indentifier under cursor
