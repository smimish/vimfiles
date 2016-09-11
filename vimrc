" This must be first, because it changes other options as side effect
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

set ignorecase  " ignore case when searching
set smartcase   " ignore case if search pattern is all lowercase, case-sensitive otherwise

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


" Making .md files to be of the Markdown syntax
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

""""""""""""""""""
" Key mappings
""""""""""""""""""
" Map space to leader
map <Space> <Leader>

" File commands
noremap <Leader>fs :w<CR>
noremap <Leader>fS :wall<CR>
noremap <silent> <Leader>ft :call ToggleVExplorer()<CR>
noremap <silent> <Leader>ff :CtrlP<CR>

" Window commands
nmap <silent> <Leader>wk :wincmd k<CR>
nmap <silent> <Leader>wK :wincmd K<CR>
nmap <silent> <Leader>wj :wincmd j<CR>
nmap <silent> <Leader>wJ :wincmd J<CR>
nmap <silent> <Leader>wh :wincmd h<CR>
nmap <silent> <Leader>wH :wincmd H<CR>
nmap <silent> <Leader>wl :wincmd l<CR>
nmap <silent> <Leader>wL :wincmd L<CR>

nmap <silent> <Leader>ws :wincmd s<CR>
nmap <silent> <Leader>wv :wincmd v<CR>
nmap <silent> <Leader>wc :wincmd c<CR>

noremap <Leader>qs :xa<CR>
noremap <Leader>qq :q!<CR>
noremap <Leader>t :tabe<CR>
noremap <Leader>h :set hls!<CR>

noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gd :Gdiff<CR>

" Make F5 to highlight / unhighlight
noremap <F4> :tabe %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
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
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'justinmk/vim-syntax-extra'
call plug#end()

""""""""""""""""""
" CtrlP settings
""""""""""""""""""
let g:ctrlp_max_files = 1000
let g:ctrlp_max_depth = 10
let g:ctrlp_custom_ignore = '\v\.(tsk|o|d|dd)$'
set wildignore=*.tsk,*.o,*.d,*.dd " Algo setting the same for vimgrep


""""""""""""""""""
" Netrw settings
""""""""""""""""""
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25 " Make netrw window to be 25% of the window size
let g:netrw_banner=0 " Disable banner on top
let g:netrw_dirhistmax = 0 " Disable saving history for netrw

" Toggle Vexplore
function! ToggleVExplorer()
if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec 'wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
