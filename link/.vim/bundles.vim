set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles
" =======
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color'

Bundle 'vim-scripts/bufkill.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'plasticboy/vim-markdown'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/keepcase.vim'

Bundle 'ap/vim-css-color'
Bundle 'docunext/closetag.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'epeli/slimux'
"Bundle 'christoomey/vim-tmux-navigator'
" =======

filetype plugin indent on     " required!
