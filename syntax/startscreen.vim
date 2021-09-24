if exists("b:current_syntax") | finish | endif

execute 'syntax region startscreenHeader start=/\%1l/ end=/\%'. (len(g:startscreen_header) - 6) .'l/'
execute 'syntax region startscreenFooter start=/\%'. (len(g:startscreen_header) - 5) .'l/' . ' end=/\%'. (len(g:startscreen_header) + 2) .'l/'

highlight default link startscreenHeader Comment
highlight default link startscreenFooter Constant

let b:current_syntax = 'startscreen'
