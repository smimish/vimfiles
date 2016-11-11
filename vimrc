" This must be first, because it changes other options as side effect
set nocompatible " disables vi compatibility mode

" Plugins
if has('win32')
    call plug#begin('~/vimfiles/bundle')
else
    call plug#begin('~/.vim/bundle')
endif
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'crusoexia/vim-monokai'
call plug#end()

syntax on
set t_Co=256 
" colorscheme molokai
colorscheme monokai

if has('gui_running')
    set guioptions=i " Remove toolbal/menubar/filebar
    if has('unix')
        " set guifont=Consolas\ 13
        set guifont=Inconsolata\ Medium\ 12
    endif
    if has('win32')
        set guifont=Inconsolata:h12:cANSI
    endif
    set lines=45
    set columns=110
endif

set encoding=utf-8
set fileencoding=utf-8
set ff=unix " Force Unix file format
set fileformats=unix,dos " Save new files in Unix on all platforms

set ttyfast

" Switch on line numbers
set number

" Each indentation level is four spaces. Tabs are not used.
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1 " Use value of shiftwidth
set shiftwidth=0   " autoident. 0 - use tabstop value 
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


" makes auto-complete to be on top
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
if has('win32')
    noremap <silent> <Leader>fed :e ~/vimfiles/vimrc<CR>
else
    noremap <silent> <Leader>fed :e ~/.vim/vimrc<CR>
endif

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

nmap <silent> <Leader>wd :wincmd c<CR>
nmap <silent> <Leader>wD :wincmd o<CR>

" Buffer commands
nmap <silent> <Leader><tab> :b#<CR>

" Config/toggle commands
nmap <silent> <Leader>tn :set number!<CR>
nmap <silent> <Leader>tl :set wrap!<CR>

nmap <silent> <Leader>Tm :call ToggleGUIMenu()<CR>

" Tab commands
nmap <silent> <Leader>tt :tabe<CR>
nmap <silent> <Leader>1 :tabnext 1<CR>
nmap <silent> <Leader>2 :tabnext 2<CR>
nmap <silent> <Leader>3 :tabnext 3<CR>
nmap <silent> <Leader>4 :tabnext 4<CR>
nmap <silent> <Leader>5 :tabnext 5<CR>
nmap <silent> <Leader>6 :tabnext 6<CR>
nmap <silent> <Leader>7 :tabnext 7<CR>
nmap <silent> <Leader>8 :tabnext 8<CR>
nmap <silent> <Leader>9 :tabnext 9<CR>

" Search commands 
noremap <Leader>sc :set hls!<CR>

" GIT Commands
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gd :Gdiff<CR>


" Quit commands
noremap <Leader>qs :xa<CR>
noremap <Leader>qq :qa!<CR>

" Make F5 to highlight / unhighlight
noremap <F5> :set hls!<CR>
noremap <F4> :tabe %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
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


""""""""""""""""""
" CtrlP settings
""""""""""""""""""
let g:ctrlp_max_files = 1000
let g:ctrlp_max_depth = 10
let g:ctrlp_custom_ignore = '\v\.(tsk|o|d|dd)$'
set wildignore=*.tsk,*.o,*.d,*.dd " Also setting the same for vimgrep


""""""""""""""""""
" Netrw settings
""""""""""""""""""
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25     " Make netrw window to be 25% of the window size
let g:netrw_banner=0       " Disable banner on top
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

function! ToggleGUIMenu()
  if &guioptions=='i'
    exec('set guioptions=im')
  else
    exec('set guioptions=i')
  endif
endfunction
