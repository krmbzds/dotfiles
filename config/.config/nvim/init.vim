"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('altercation/vim-colors-solarized')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set number
set wrap
set linebreak                   " break lines by words
set scrolloff=5                 " set scroll offset to 5
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
set background=light            " use light background
set gdefault                    " global replace by default
set hlsearch                    " highlight search
set incsearch                   " incremental search
set ignorecase                  " ignore case if all lower case
set smartcase                   " if mixed make case sensitive search
set showcmd                     " display the last comment
set backspace=indent,eol,start  " make backspace act normally

" use regex search by default
nnoremap / /\v
vnoremap / /\v

" traverse over visual lines by default
nnoremap j gj
nnoremap 0 g0

" use fzf
set rtp+=~/.homebrew/opt/fzf

" set color scheme
colorscheme solarized

" the breeze still follows its path
command! Wq wq
