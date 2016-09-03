set nocompatible " disables vi compatibility mode

syntax on
colorscheme molokai

if has('gui_running')
    set guifont=Consolas:h12:cANSI
    set guioptions-=T " Remove toolbar
"   set guioptions-=M " Remove filebar, menubar
"   set guioptions-=r " Remove scrollbar
endif

set encoding=utf-8
set fileencoding=utf-8
set ff=unix " Force unix file format
set fileformats=unix,dos " Save new files in unix on all platforms

set ttyfast

" Switch on line numbers
set number

" Each indentation level is four spaces. Tabs are not used.
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set sw=4 " This is the level of autoindent
set autoindent


" makes VIM to use the common clipboard
set clipboard=unnamed

" makes autocomplete to be on top
set wildmenu

" enabling backspace to behave as in normal editors
fixdel
set backspace=indent,eol,start

" Disable saving history for netrw
let g:netrw_dirhistmax = 0

" Making .md files to be of the Markdown syntax
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Key mappings
" Make CTRL-T to open a new tab
noremap <C-T> :tabe<CR>
" Make F5 to highlight / unhighlight
noremap <F5> :set hls!<CR>
" F6 - close current tab
noremap <F6> :update<CR>:q!<CR>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Statusline
set laststatus=2
set statusline=
set statusline+=[%n%H%M%R%W]\         " flags and buf no
set statusline+=%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())?fugitive#statusline().'\ ':''}
set statusline+=%.45f\            " file path, max 45 characters
set statusline+=%= " Right aligning
set statusline+=%{strlen(&ft)?&ft:'none'}, " file type
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}              " file format
set statusline+=\  
set statusline+=%l\/%L,%c           " line and column

set guitablabel=\[%N\]\ %t\ %M " Set tab labels, first number is useful to switch to 

" Plugins
call plug#begin('~/vimfiles/bundle')
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" Change to the defautl dir
:cd D:\Notes
