
@set force=0
@set dryrun=0
@set prefix=%USERPROFILE%

@set NAME=%~nx0
@set VERSION=dotfiles_%NAME% 0.0.0
@set USAGE=Usage: %NAME% [options] [file ..]

:: skip over the 'function' definitions
@goto start

:: function print_help {{{
:print_help
  @echo.%VERSION%
  @echo.%USAGE%
  @echo.
  @echo.  -f, --force      overwrite existing files
  @echo.  -h, --help       show this help
  @echo.  -n, --dry-run    print out what will happen
  @echo.      --prefix=DIR directory to install into
  @echo.      --version    display version number
  @echo.
  @goto :eof
:: }}}

:: function print_badArg {{{
:print_badArg
  @echo.%NAME%: unknown option %~1 1>&2
  @echo.Try `%NAME% --help' for more information 1>&2
  @goto :eof
:: }}}

:start

:: parse argument loop {{{
:begin_parse
@if [%1]==[] @goto process
@set arg=%~1
@set single=%arg:~0,1%
@set double=%arg:~0,2%

@if ["%double%"]==["--"] @(
    if ["%arg%"]==["--force"] (
        set force=1
    ) else if ["%arg%"]==["--dry-run"] (
        set dryrun=1
    ) else if ["%arg%"]==["--prefix"] (
        set prefix=
    ) else if ["%arg%"]==["--help"] (
        call:print_help
        goto :eof
    ) else if ["%arg%"]==["--version"] (
        echo.%VERSION%
        goto :eof
    ) else (
        call:print_badArg %arg%
        goto :eof
    )
) else @if ["%single%"]==["-"] (
    if ["%arg%"]==["-f"] (
        set force=1
    ) else if ["%arg%"]==["-n"] (
        set dryrun=1
    ) else if ["%arg%"]==["-h"] (
        call:print_help
        goto :eof
    ) else (
        call:print_badArg %arg%
        goto :eof
    )
) else @if ["%prefix%"]==[""] (
    set prefix=%arg%
) else (
    echo %arg%
)

@shift

@goto begin_parse
:: }}}

:process

@if [%force%]==[1] @echo FORCE
@if [%dryrun%]==[1] @echo DRYRUN
@echo prefix = '%prefix%'
