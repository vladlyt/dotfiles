" Enable syntax highlighting
syntax on

" Set the file encoding
set encoding=utf-8

" Enable line numbers
set number

" Set the tab width and use spaces instead of tabs
set tabstop=4       " Number of spaces that a <Tab> counts for
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set expandtab       " Use spaces instead of tabs

" Enable auto-indentation
set autoindent
set smartindent

" Highlight current line
set cursorline

" Enable mouse support
set mouse=a

" Show matching parentheses
set showmatch

" Set the clipboard to use the system clipboard
set clipboard=unnamedplus

" Enable persistent undo
set undofile
set undodir=~/.vim/undodir

" Set the default split direction
set splitbelow       " Horizontal splits will open below current window
set splitright       " Vertical splits will open to the right of current window

" Enable search highlighting
set hlsearch
set incsearch

" Set colorscheme
colorscheme default

" Show line endings and tabs
set list
set listchars=tab:▸\ ,trail:•,extends:>,precedes:<

" Enable file type detection and plugins
filetype plugin indent on

" Set status line
set laststatus=2

" Set a reasonable timeout for mapped keys
set timeoutlen=500
