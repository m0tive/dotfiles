@setlocal

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set force=
@set dryrun=
@set all=
@set files=
@set cygwin=
@set cygwin_path=%SystemDrive%\cygwin\home\%USERNAME%
@set prefix=%HOME%

@set NAME=%~nx0
@set VERSION=dotfiles_%NAME% 0.0.0
@set USAGE=Usage: %NAME% [options] [file ..]

:: check if this is cygwin {{{
@if defined PS1 @if defined PWD @(
  echo.%NAME%: not intended for cygwin 1>&2
  echo.Try `install.sh` instead 1>&2
  goto quit
)
:: }}}

:: skip over the 'function' definitions
@goto start

:: print_help {{{
:print_help
  @echo.%VERSION%
  @echo.%USAGE%
  @echo.
  @echo.      --cygwin-home=DIR dirctory to install cygwin components into
  @echo.  -f, --force           overwrite existing files
  @echo.  -h, --help            show this help
  @echo.  -n, --dry-run         print out what will happen
  @echo.      --prefix=DIR      directory to install into
  @echo.      --version         display version number
  @echo.
  @echo.`%NAME%' or `%NAME% all' will install all dotfiles excluding cygwin.
  @echo.`%NAME% cygwin' will install just the cygwin dotfiles.
  @echo.`%NAME% all cygwin' will install everything.
  @goto :eof
:: }}}

:: warning {{{
:warning
  @echo.%~1 1>&2
  @goto :eof
:: }}}

:: error {{{
:error
  @echo.%NAME%: %~1 1>&2
  @echo.Try `%NAME% --help' for more information 1>&2
  @goto :eof
:: }}}

:: install {{{
:install
    @if "%~2" EQU "" @goto :eof
    @set arg=%~1

    @set dot=
    @if "%~3" EQU "" @set dot=.

    @set firstChar=%arg:~0,1%
    @set name=%~n1

    @if "%~sdp1\%firstChar%" EQU "%~sdp0\." @goto :eof
    @if "%~sf1" EQU "%~sdp0install.bat" @goto :eof
    @if "%~sf1" EQU "%~sdp0install.sh" @goto :eof
    @if "%~sf1" EQU "%~sdp0cygwin" @goto :eof

    @if not exist "%~fs1" @(
        call:warning "skipping `%~1', file doesn't exist"
        goto :eof
    )

    :: if it is a directory, call recursively. (there is no dos `cp -r`)
    @if exist %~sf1\NUL @(
        @if defined dot @echo.mkdir "%~fs2\%dot%%~nx1" 2^>NULL
        for %%i in (%~sf1\*) do @call:install "%%~i" "%~fs2\%dot%%~nx1" 1
        for /d %%i in (%~sf1\*) do @call:install "%%~i" "%~fs2\%dot%%~nx1" 1
        goto :eof
    )

    @for %%I in ("%~fs2\%dot%%~nx1") do @set dstFile=%%~fsI

    @if defined dot @echo.copy "%~fs1" "%dstFile%"
    @goto :eof
:: }}}

:start

@if "%~1" EQU "" @(
    echo.%USAGE%
    goto quit
)

:: parse argument loop {{{
:begin_parse
@if "%~1" EQU "" @goto process
@set arg=%~1
@set single=%arg:~0,1%
@set double=%arg:~0,2%

@if not defined prefix @(
    set prefix=%arg%
) else if not defined cygwin_path (
    set cygwin_path=%arg%
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
) else if "%arg%" EQU "--cygwin-home" (
    set cygwin_path=
    set cygwin=1
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
) else if "%arg%" EQU "cygwin" (
    set cygwin=1
) else (
    (set files=%files%"%arg%" )
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

@if defined cygwin @if not exist "%cygwin_path%" @(
    call:warning "cygwin home `%cygwin_path%' does not exist, skipping cygwin install"
    set cygwin_path=
    set cygwin=
)

@if defined files @(
    for %%i in (%files%) do @call:install "%%~i" "%prefix%"
) else if defined all (
    for %%i in (*) do @call:install "%%~i" "%prefix%"
    for /d %%i in (*) do @call:install "%%~i" "%prefix%"
)

@if defined cygwin @(
    for %%i in (cygwin\*) do @call:install "%%~i" "%cygwin_path%"
    @rem for /d %%i in (cygwin\*) do @call:install "%%~i" "%cygwin_path%"
)

:quit

@endlocal

:End
