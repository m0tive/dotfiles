
@set force=0
@set dryrun=0

:begin_parse
@if [%1]==[] @goto process
@set arg=%~1
@set single=%arg:~0,1%
@set double=%arg:~0,2%
@set prefix=%arg:~0,9%

@if [%double%]==[--] @(
    if ["%arg%"]==["--force"] (
        set force=1
    ) else if ["%arg%"]==["--dry-run"] (
        set dryrun=1
    ) else if ["%prefix%"]==["--version"] (
        echo VERSION
        goto :eof
    ) else if ["%arg%"]==["--help"] (
        echo HELP!
        goto :eof
    ) else if ["%arg%"]==["--version"] (
        echo VERSION
        goto :eof
    ) else (
        echo UNKNOWN OPTION
        goto :eof
    )
) else @if [%single%]==[-] (
    echo single dash
) else (
    echo %arg%
)

@shift

@goto begin_parse

:process

@if [%force%]==[1] @echo FORCE
@if [%dryrun%]==[1] @echo DRYRUN

