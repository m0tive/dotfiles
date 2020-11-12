source $HOME//.vimrc

"set shell=cmd
"set shellcmdflag=/c

if has("win16") || has("win32") || has("win64")
	let s:os = "Windows"
else
	let s:os = substitute(system('uname'), "\n", "", "")
endif

if s:os == "Windows"
	set gfn=Lucida_Console:h9:cANSI
	set gfn=Bitstream_Vera_Sans_Mono:h9:cANSI

	" fullscreen toggle
	map <F11> :simalt ~x<CR>
	map <S-F11> :simalt ~r<CR>
	map! <F11> <C-O><F11>
	map! <S-F11> <C-O><S-F11>
elseif s:os == "Linux"
	set gfn=Bitstream\ Vera\ Sans\ Mono\ 9
end

set go-=m " no menu bar - hard-mode!
set go-=T " no toolbar
set go+=LlRrb " kill all scrollbars
set go-=LlRrb " kill all scrollbars

set clipboard=unnamed

colors desert

" Highlight characters over the character limit with a red background
" and set the default limit to 80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Disabled the OverLength highlight on vimperator inputs, it uses SmoothWrap defined in vimrc
au BufRead,BufNewFile vimperator-*.tmp hi clear OverLength

if filereadable(expand("$HOME//.gvimrc.local"))
	source $HOME//.gvimrc.local
endif
