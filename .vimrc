
" Vim not vi
set nocompatible

" Vim verboseness
"set verbose=9

filetype plugin on
set ofu=syntaxcomplete#Complete

" Add custom syntax files
au BufRead,BufNewFile *.sl set filetype=rmshader
"au! Syntax rmshader source /home/peter/sl.vim
au BufRead,BufNewFile *.sl set syntax=sl

" Set processing pde file to java highlighting
au BufRead,BufNewFile *.pde set filetype=java

" Set textile file type for hightlighting
au BufRead,BufNewFile *.textile set filetype=textile

au BufNewFile,BufRead SConstruct*,SConscript* set filetype=python

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
au BufRead,BufNewFile Makefile*,*.sh,.*rc,.*profile set noexpandtab

" Do automatic indenting
set autoindent
set smartindent

filetype indent on
set foldmethod=marker

map ,{ :s/^[[:space:]]*/&\/\/ {{{\r&/<CR>zokf{
map ,} :s/$/ \/\/}}}/<CR>

" Comment shortcuts

au BufRead,BufNewFile *.py,*.pyw map ,# :s/^/#/<CR>l
au BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp,*.java,*.pde map ,/ :s/^/\/\//<CR>ll
au BufRead,BufNewFile *.tex map ,/ :s/^/%%/<CR>ll
au BufRead,BufNewFile .vimrc map ,/ :s/^/"/<CR>ll
map ,\ :s/^\(\/\{2,}\\|#\+\\|%%\{2,})//<CR>

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

" tabed file stuff
"set showtabline=2

"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
set wmh=0


" lock the arrow keys in insert mode (make me a better person!)
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

set spelllang=en_gb

" <C-a> and <C-x> behaviour
set nf=octal,hex,alpha

" Ctag file
set tag=./tags;/

" Complete behaviour
"set completeopt+=longest,menuone

filetype plugin on

set tags=tags;/
set tags+=~/.vim/tags/cpp

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Better make command!
command -nargs=* Make write | make! <args> | cwindow
