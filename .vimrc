set nocompatible 
set encoding=utf-8 
set fileencoding=utf-8 
set nobackup 
set magic
syntax enable
filetype indent on
set laststatus=2 
set showmode 
set ruler 
set smartindent 
set shiftwidth=2 
set softtabstop=-1
set showmatch
set hlsearch 
set incsearch 
set ignorecase 
set smartcase 
syntax on 
" set number 
set textwidth=80 
set scrolloff=5 
set noerrorbells
" set list
" set listchars=tab:>-,space:-

map rc :source $MYVIMRC<CR>
map <leader>rc :e ~/.vimrc<CR>
