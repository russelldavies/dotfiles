" Plugins
" =======
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'elmcast/elm-vim'
Plug 'epeli/slimux'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
"Plug 'whatyouhide/vim-lengthmatters'

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


" Misc
" ====
set undofile
set clipboard=unnamed  " System clipboard integration


" Colors
" ======
colorscheme solarized
set background=dark
call togglebg#map("<leader>b")  " Easily toggle background


" Spaces & Tabs
" =============
filetype plugin indent on
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4


" UI Config
" =========
set nowrap nolinebreak
function! ToggleWrap()
    if (&wrap == 1)
        set nowrap nolinebreak
    else
        set wrap linebreak
    endif
endfunction
map <leader>w :call ToggleWrap()<CR>
set colorcolumn=80
set list listchars=tab:→\ ,trail:·,precedes:❮,extends:❯
set cpoptions+=n
set showbreak=\ \ ↳\ 

set number relativenumber  " both set for hybrid line number mode
set ruler
set showcmd

" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
nmap <leader>s :setlocal invspell<cr>

" Buffer helpers
nmap <c-e> :e#<cr>
nnoremap <leader>l :ls<cr>:b<space>


" Search
" ======
set ignorecase smartcase
nnoremap <leader>q :nohlsearch<cr>


" Folding
" =======
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf


" Plugin Config
" =============
" ctrlp
nmap <leader>r :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

" nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" vim-airline
set laststatus=2
let g:airline_theme='solarized'

" Mundo
nnoremap <leader>u :MundoToggle<CR>

" Ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
