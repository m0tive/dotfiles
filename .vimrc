

" Vim not vi
set nocompatible

" Vim verboseness
"set verbose=9

" Enable syntax highlighting
syntax on

" Adjust colours for dark background
set bg=dark

" Backspace over everything
set backspace=indent,eol,start

" Indent width
set shiftwidth=4
set tabstop=4
"set smarttab
set softtabstop=4

fu Select_tab_style()
    if search('^\t', 'n', 150)
        set noexpandtab
    el
        " Spaces, not tabs
        set expandtab
    en
endf
au BufRead,BufNewFile * call Select_tab_style()
" Don't expand tabs on Makefiles of shell scripts
au BufRead,BufNewFile Makefile*,*.sh,.*rc set noexpandtab

" Do automatic indenting
set autoindent
set smartindent

filetype indent on

"set foldmethod=indent

"au BufRead,BufNewFile *.py,*.pyw setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"au BufRead,BufNewFile *.rib setlocal smartindent cinwords=WorldBegin

" Set the fileformat of new files to unix
au BufNewFile * set fileformat=unix

" Show whitespaces
set list
set listchars=tab:>\ 
set listchars+=trail:.

" Add bad whitespace colouring
highlight BadWhitespace ctermbg=red guibg=red
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.hpp,Makefile*,*.sh match BadWhitespace /\s\+$/

" Ignore case when searching
set ignorecase
set smartcase

" Turn off beep on error
set vb t_vb=

" Select with mouse
"set selectmode=mouse

" Command prompt height
"set cmdheight=2

" do not keep backup files
"set nobackup
"set nowritebackup

" History length
set history=50

" Show cursor position all the time
set ruler

" Use better (incremental) search
set incsearch

" Set full free roaming command cursor
"set virtualedit=all

" Show (partial) commands
"set showcmd " I'm not sure what this does...

" Set ignorecase on
"set ignorecase

