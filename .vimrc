syntax on

set number
set wrap
set linebreak " break lines by words
set scrolloff=5 " set scroll offset to 5

" unmap arrow keys in normal mode
" to force use of h,j,k,l keys
noremap <left> <nop>
noremap <down> <nop>
noremap <right> <nop>
noremap <up> <nop>

set gdefault " global replace by default

set hlsearch " highlight search
set incsearch " incremental search
set ignorecase " ignore case if all lower case
set smartcase " if mixed make case sensitive search

set showcmd " display the last comment

" use regex search by default
nnoremap / /\v
vnoremap / /\v

" traverse over visual lines by default
nnoremap j gj
nnoremap 0 g0
