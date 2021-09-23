if exists("b:current_syntax") | finish | endif

execute 'syntax region startscreenHeader start=/\%1l/ end=/\%'. (len(g:startscreen_header) + 2) .'l/'

highlight default link startscreenHeader  Title

let b:current_syntax = 'startscreen'
