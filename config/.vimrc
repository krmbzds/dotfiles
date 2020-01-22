syntax on

set number
set wrap
set linebreak                   " break lines by words
set scrolloff=5                 " set scroll offset to 5
set nocompatible                " break away from old vi compatibility
set encoding=utf-8 nobomb       " use utf-8 w/o bom
set shortmess=atI               " mute intro message
set showcmd                     " show partial command as it is typed
set showmatch                   " show matching brackets
set showmode                    " show current mode
set softtabstop=2               " make tabs as wide as two spaces
set tabstop=2                   " make tabs as wide as two spaces
set shiftwidth=2                " set > tab to 2 spaces
set expandtab                   " use spaces instead of tabs
set tabpagemax=15               " maximum 15 tabs
set ttyfast                     " optimize for fast terminal connections
set wildmenu                    " enchance cli completion

" make backspace act normally
set backspace=indent,eol,start

" unmap arrow keys in normal mode
" to force use of h,j,k,l keys
noremap <left> <nop>
noremap <down> <nop>
noremap <right> <nop>
noremap <up> <nop>

set gdefault " global replace by default

set hlsearch   " highlight search
set incsearch  " incremental search
set ignorecase " ignore case if all lower case
set smartcase  " if mixed make case sensitive search

set showcmd " display the last comment

" use regex search by default
nnoremap / /\v
vnoremap / /\v

" traverse over visual lines by default
nnoremap j gj
nnoremap 0 g0

set rtp+=~/.homebrew/opt/fzf    " use fzf

set directory=~/.vim/swaps      " centralized swaps
set backupdir=~/.vim/backups    " centralized backups
set undodir=~/.vim/undo         " centralized undo history

set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
