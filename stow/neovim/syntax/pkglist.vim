if exists("b:current_syntax") | finish | endif

syn match pkgMeta    /^# \(columns\|legend\):.*/
syn match pkgHeader  /^## .*/

syn match pkgBracket /[\[\]]/ contained
syn match pkgOn      /[a-z]/  contained
syn match pkgOff     /-/      contained
syn match pkgFlags   /^\[[a-z-]\+\]/ contains=pkgBracket,pkgOn,pkgOff

syn match pkgName    /\(^\[[^\]]*\]\s\+\)\@<=\S\+/
syn match pkgDesc    /\(^\[[^\]]*\]\s\+\S\+\s\+\)\@<=.*/
syn match pkgNoDesc  /\(^\[[^\]]*\]\s\+\S\+\s\+\)\@<=nodesc$/

hi def link pkgMeta    Comment
hi def link pkgHeader  Title
hi def link pkgBracket Delimiter
hi def link pkgOn      String
hi def link pkgOff     Comment
hi def link pkgName    Identifier
hi def link pkgDesc    Normal
hi def link pkgNoDesc  WarningMsg

let b:current_syntax = "pkglist"
