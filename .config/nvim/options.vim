" use the + register for copy and paste. This syncs yank to the system
" clipboard.
set clipboard+=unnamedplus
" Ignore these files when using wildcards
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase " ignore file and dir name cases in cmd-completion
" General tab settings
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces
" Match pairs of characters
set matchpairs+="<:>, \":\", ':'"
" Line settings
set number relativenumber
set scrolloff=6
" File settings
set fileencoding=utf-8
set noswapfile " Don't use swapfiles when editing files
" TODO make it so that cursor stays where it is when doing C-d
