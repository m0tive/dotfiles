
@set force=0
@set dryrun=0
@set prefix=%USERPROFILE%

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
        echo HELP!
        goto :eof
    ) else if ["%arg%"]==["--version"] (
        echo VERSION
        goto :eof
    ) else (
        echo UNKNOWN OPTION
        goto :eof
    )
) else @if ["%single%"]==["-"] (
    if ["%arg%"]==["-f"] (
        set force=1
    ) else if ["%arg%"]==["-n"] (
        set dryrun=1
    ) else (
        echo UNKNOWN OPTION
        goto :eof
    )
) else @if ["%prefix%"]==[""] (
    set prefix=%arg%
) else (
    echo %arg%
)

@shift

@goto begin_parse

:process

@if [%force%]==[1] @echo FORCE
@if [%dryrun%]==[1] @echo DRYRUN
@echo prefix = '%prefix%'
