source $HOMEDRIVE/.vimrc

if has("win16") || has("win32") || has("win64")
	let s:os = "Windows"
else
	let s:os = substitute(system('uname'), "\n", "", "")
endif

if s:os == "Windows"
	set gfn=Lucida_Console:h9:cANSI
	set gfn=Bitstream_Vera_Sans_Mono:h9:cANSI
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

if filereadable(expand("$HOMEDRIVE/.gvimrc.local"))
	source $HOMEDRIVE/.gvimrc.local
endif
