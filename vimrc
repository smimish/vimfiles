set nocompatible " disables vi compatibility mode

syntax on
colorscheme molokai

if has('gui_running')
    set guioptions-=T " Remove toolbar
"   set guioptions-=M " Remove filebar, menubar
"   set guioptions-=r " Remove scrollbar
    if has('unix')
        set linespace=4
        set guifont=Consolas\ 13
    endif
    if has('win32')
        set linespace=1
        set guifont=Consolas:h10:cANSI
    endif
    set lines=45
    set columns=110
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

" disabling modeline (parameters which can be passed from files into vim)
set modelines=0
set nomodeline

" disabling swap and backup files
set noswapfile
set nobackup

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
" Map space to leader
map <Space> <Leader>

noremap <Leader>w :w<CR>
noremap <Leader>q :q!<CR>
noremap <Leader>t :tabe<CR>

" Make F5 to highlight / unhighlight
noremap <F5> :set hls!<CR>
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
if has('win32')
    call plug#begin('~/vimfiles/bundle')
else
    call plug#begin('~/.vim/bundle')
endif
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

""""""""""""""""""
" CtrlP settings
""""""""""""""""""
" Search by filenames by default, and not by full path
" Can be toggled on/off by pressing <c-d> inside the prompt.
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 1000
let g:ctrlp_max_depth = 10
let g:ctrlp_custom_ignore = '\v\.(tsk|o|d|dd)$'
set wildignore=*.tsk,*.o,*.d,*.dd " Algo setting the same for vimgrep

" Change to the defautl dir
:cd D:\Notes
