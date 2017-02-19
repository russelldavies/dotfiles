" Plugins
" =======
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/bufkill.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/keepcase.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'epeli/slimux'
Plug 'tmhedberg/SimpylFold'
Plug 'sjl/gundo.vim'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'whatyouhide/vim-lengthmatters'
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Misc
" ====
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set ttyfast
set undofile
autocmd! bufwritepost .vimrc source % " Automatic reloading of .vimrc
set clipboard=unnamed " System clipboard integration
au FocusLost * :wa " Save buffer when focus lost

" Colors
" ======
syntax on
colorscheme solarized
" Adjust according to time of day
if strftime("%H") > 8 && strftime("%H") < 19
  set background=light
else
  set background=dark
endif
call togglebg#map("<leader>b") " Easily toggle background

" Spaces & Tabs
" =============
filetype plugin indent on
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" UI Config
" =========
function! ToggleWrap()
    if (&wrap == 1)
        set nowrap nolinebreak
    else
        set wrap linebreak
    endif
endfunction
map <leader>w :call ToggleWrap()<CR>

set nowrap nolinebreak
set textwidth=0
set colorcolumn=80
:set list listchars=tab:→\ ,trail:·,precedes:❮,extends:❯

set modelines=1
set display=lastline " show partial lines wrapped past bottom of screen (stop @ display)
set number relativenumber " both set for hybrid line number mode
set ruler
set history=100
set wildmenu " visual autocomplete for command menu
set matchpairs+=<:> " match < and > as well
set showcmd " show command in bottom bar
" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
nmap <leader>s :setlocal invspell<cr>
" Buffer helpers
nmap <c-e> :e#<cr>
nnoremap <leader>l :ls<cr>:b<space>
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" Search
" ======
set hlsearch incsearch ignorecase smartcase
nnoremap <leader>q :nohlsearch<cr>   " Turn off search highlight

" Folding
" =======
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf

" Plugin Config
" =============
" ctrlp.vim (replaces FuzzyFinder and Command-T)
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
nmap <leader>r :CtrlPBuffer<cr>
"let g:ctrlp_match_window_reversed = 0
"let g:ctrlp_switch_buffer = 0
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

" nerdtree
:nmap <leader>e :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" vim-airline
set laststatus=2 "Always show the status bar
let g:airline_theme='solarized'

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Alt-p pipes the current buffer to the current filetype as a command
" (good for perl, python, ruby, shell, gnuplot...)
nmap <M-p>  :call RunUsingCurrentFiletype()<cr>
nmap <Esc>p :call RunUsingCurrentFiletype()<cr>
function! RunUsingCurrentFiletype()
    execute 'write'
    execute '! clear; '.&filetype.' <% '
endfunction