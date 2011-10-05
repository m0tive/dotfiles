@setlocal

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set force=
@set dryrun=
@set prefix=%HOME%
@set all=
@set files=

@set NAME=%~nx0
@set VERSION=dotfiles_%NAME% 0.0.0
@set USAGE=Usage: %NAME% [options] [file ..]

@if defined PS1 @if defined PWD @(
  echo.%NAME%: not intended for cygwin 1>&2
  echo.Try `install.sh` instead 1>&2
  goto quit
)

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
:error
  @echo.%NAME%: %~1 1>&2
  @echo.Try `%NAME% --help' for more information 1>&2
  @goto :eof
:: }}}

:: function install {{{
:install
    @set arg=%~1
    @set firstChar=%arg:~0,1%
    @set name=%~n1
    @if "%firstChar%" EQU "." @goto :eof
    @if "%name%" EQU "install" @goto :eof

    @for %%I in (%prefix%\.%~nx1) do @set dstFile=%%~fsI

    @if "%arg%" EQU "cygwin" @(
        if defined cygwin (
            echo.install %cygwin%?
        )
        goto :eof
    )

    @echo.copy "%~fs1" "%dstFile%"
    @goto :eof
:: }}}

:start

:: parse argument loop {{{
:begin_parse
@if [%1]==[] @goto process
@set arg=%~1
@set single=%arg:~0,1%
@set double=%arg:~0,2%

@if not defined prefix @(
    set prefix=%arg%
) else if "%arg%" EQU "--force" (
    set force=1
) else if "%arg%" EQU "-f" (
    set force=1
) else if "%arg%" EQU "--dry-run" (
    set dryrun=1
) else if "%arg%" EQU "-n" (
    set dryrun=1
) else if "%arg%" EQU "--prefix" (
    set prefix=
) else if "%arg%" EQU "--help" (
    call:print_help
    goto quit
) else if "%arg%" EQU "-h" (
    call:print_help
    goto quit
) else if "%arg%" EQU "--version" (
    echo.%VERSION%
    goto quit
) else if "%double%" EQU "--" (
    call:error "unknown option %arg%"
    goto quit
) else if "%single%" EQU "-" (
    call:error "unknown option %arg%"
    goto quit
) else if "%arg%" EQU "all" (
    set all=1
) else (
    (set files=%files%"%arg%" )
    if "%arg%" EQU "cygwin" if not defined cygwin (
        for %%I in ("%SystemDrive%\cygwin\home\%USERNAME%") do @set cygwin=%%~fsI
    )
)

@shift

@goto begin_parse
:: }}}

:process

@if defined all @set files=

@if not exist "%prefix%" @(
    call:error "prefix `%prefix%' does not exist"
    goto quit
)

@if not exist "%cygwin%" @set cygwin=

@if defined files @(
    for %%i in (%files%) do @call:install "%%~i"
) else (
    for %%i in (*) do @call:install "%%~i"
    for /d %%i in (*) do @call:install "%%~i"
)

:quit

@endlocal

:End
