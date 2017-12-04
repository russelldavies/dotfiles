" Plugins
" =======
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'elmcast/elm-vim'
Plug 'epeli/slimux'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'tmux-plugins/vim-tmux-focus-events'
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
nmap <leader>s :setlocal invspell<CR>


" Colors
" ======
colorscheme solarized8_dark
" Toggle between dark and light background
nnoremap  <leader>b :<c-u>exe "colors" (g:colors_name =~# "dark"
    \ ? substitute(g:colors_name, 'dark', 'light', '')
    \ : substitute(g:colors_name, 'light', 'dark', '')
    \ )<cr>
" Tune contrast level
fun! Solarized8Contrast(delta)
  let l:schemes = map(["_low", "_flat", "", "_high"], '"solarized8_".(&background).v:val')
  exe "colors" l:schemes[((a:delta+index(l:schemes, g:colors_name)) % 4 + 4) % 4]
endf
nmap <leader>- :<c-u>call Solarized8Contrast(-v:count1)<cr>
nmap <leader>+ :<c-u>call Solarized8Contrast(+v:count1)<cr>


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
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h


" Search
" ======
set ignorecase smartcase
nnoremap <leader>q :nohlsearch<CR>


" Folding
" =======
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf


" Plugin Config
" =============
" nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" vim-airline
set laststatus=2
let g:airline_theme='solarized'

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1

" Elm
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0


" fzf
nmap <leader>f :Files<CR>
nmap <leader>; :Buffers<CR>
nmap <leader>l :Lines<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <leader>r :Rg<CR>
