set nocompatible 
set encoding=utf-8 
set fileencoding=utf-8 
set nobackup 
set magic
filetype indent on
"colorscheme wildcharm 
"set background=dark
set laststatus=2 
set showmode 
set ruler 
set smartindent 
set tabstop=4 
set shiftwidth=4 
"set expandtab
"set softtabstop=4
set showmatch
"set hlsearch 
set incsearch 
set ignorecase 
set smartcase 
syntax on 
set shortmess=atI
set number 
set textwidth=80 
set scrolloff=5 
set noerrorbells 

map rc :source $MYVIMRC<CR>
map <leader>rc :e ~/.vimrc<CR>
