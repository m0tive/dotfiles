fu! EscSource(path)
	execute "source " . substitute(a:path, " ", "\\\\ ", "g")
endfu

let s:path = expand("$USERPROFILE/.vimrc")
if filereadable(s:path)
	call EscSource(s:path)
else
	let s:path = substitute(system('cygpath -ua "$USERPROFILE"'), "\n", "", "") . "/.vimrc"
	if filereadable(s:path)
		call EscSource(s:path)
	endif
endif



