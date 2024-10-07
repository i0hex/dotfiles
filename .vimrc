" --- Base ---
"disable vi compatibility
set nocompatible 
"character enconding
set encoding=utf-8 
"file encoding
set fileencoding=utf-8 
"no backup file is created
set nobackup 
"regular expression(magic mode)
set magic
"filetype check 
filetype indent on

"--- UI ---
"color Theme
colorscheme wildcharm 
"enable 256Color
set t_Co=256
set background=dark

"--- Status bar ---
"show status bar
set laststatus=2 
"height of command line
" set cmdheight=1 
"show mode in status bar
set showmode 
"show command in status bar
set showcmd 
"enable ruler of status bar
set ruler 

"---Indent---
"autoindent
set smartindent 
"space number of tab
set tabstop=4 
"number of indented characters
set shiftwidth=4 
"enable tab to space
set expandtab
"number of tabulated conversions
set softtabstop=4

"---Search---
"highlight match
set showmatch
"highlight matching result
" set hlsearch 
"incremental search 
set incsearch 
"case insensitive matching
set ignorecase 
"smart case matching
set smartcase 

"---Editor---
"enable syntax highlight
syntax on 
"disable default prompts
set shortmess=atI
"automatically save
" set autowrite 
"hide buffers when they are abandoned
" set hidden 
"enable mouse usage
" set mouse=a 
"show line number
set number 
"show complementary tips
set wildmenu
"controlling filename completion behavior 
set wildmode=longest:list,full
"line width
set textwidth=80 
"cursor moves up and down by 5 lines each
set scrolloff=5 
"turn off the error tone
set noerrorbells 
"automatically wrap
set wrap 
"backspace allowed in edit mode
set backspace=indent,eol,start 
"allow fold
" set foldenable 
"manual folding
" set foldmethod=manual 

"---Keymap---
"right split screen, focus right window
map sl :set splitright<CR>:vsplit<CR>
"left split screen, focus left window
map sh :set nosplitright<CR>:vsplit<CR>
"above split screen, focus above window
map sk :set nosplitbelow<CR>:split<CR>
"below split screen, focus below window
map sj :set splitbelow<CR>:split<CR>
"cursor moves to the right window
map <leader>l <C-w>l
"cursor moves to the above window
map <leader>k <C-w>k
"cursor moves to the below window
map <leader>j <C-w>j
"cursor moves to the left window
map <leader>h <C-w>h
"new tab
map nt :tabnew<CR>
"previous tab
map tp :tabprevious<CR>
"next tac
map tn :tabnext<CR>
"reload .vimrc
map rc :source $MYVIMRC<CR>
"open .vimrc
map <leader>rc :e ~/.vimrc<CR>

inoremap <C-l> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-f> <Home>
inoremap <C-e> <End>

"---Plugin---
call plug#begin()
filetype plugin on
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"===coc===
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
