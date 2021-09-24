if exists('g:autoloaded_startscreen') || &compatible | finish | endif
let g:autoloaded_startscreen = 1


function! s:warn(msg) abort
    echohl WarningMsg
    echomsg 'startscreen: ' . a:msg
    echohl NONE
endfunction

function! s:set_custom_section(section) abort
    if type(a:section) == type([])
        return copy(a:section)
    elseif type(a:section) == type('')
        return empty(a:section) ? [] : eval(a:section)
    endif
    return []
endfunction

function! startscreen#center(lines) abort
    let longest_line = max(map(copy(a:lines), 'strwidth(v:val)'))
    return map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2) - 1) . v:val')
endfunction

function! startscreen#start() abort
    if argc() || line2byte('$') != -1 | return | endif
    if &insertmode || !&modifiable | return | endif  " Handle vim -y, vim -M.
    if !&hidden && &modified
        call s:warn('Save your changes first.')
        return
    endif
    
    silent! setlocal
                \ bufhidden=wipe
                \ colorcolumn=
                \ foldcolumn=0
                \ matchpairs=
                \ nocursorcolumn
                \ nocursorline
                \ nolist
                \ nonumber
                \ norelativenumber
                \ nospell
                \ noswapfile
                \ nobuflisted
                \ signcolumn=no
                \ synmaxcol&
    
    let g:startscreen_default_header = [
                \ '                                                                     ',
                \ '                                                                     ',
                \ '            :h-                                  Nhy`                ',
                \ '           -mh.                           h.    `Ndho                ',
                \ '           hmh+                          oNm.   oNdhh                ',
                \ '          `Nmhd`                        /NNmd  /NNhhd                ',
                \ '          -NNhhy                      `hMNmmm`+NNdhhh                ',
                \ '          .NNmhhs              ```....`..-:/./mNdhhh+                ',
                \ '           mNNdhhh-     `.-::///+++////++//:--.`-/sd`                ',
                \ '           oNNNdhhdo..://++//++++++/+++//++///++/-.`                 ',
                \ '      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:        ',
                \ ' .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+         ',
                \ ' h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`          ',
                \ ' hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`         ',
                \ ' /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.        ',
                \ '  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.       ',
                \ '   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.      ',
                \ '     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`     ',
                \ '       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:     ',
                \ '       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`    ',
                \ '       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:    ',
                \ '       //+++//++++++////+++///::--                 .::::-------::    ',
                \ '       :/++++///////////++++//////.                -:/:----::../-    ',
                \ '       -/++++//++///+//////////////               .::::---:::-.+`    ',
                \ '       `////////////////////////////:.            --::-----...-/     ',
                \ '        -///://////////////////////::::-..      :-:-:-..-::.`.+`     ',
                \ '         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -    ',
                \ '           ::::://::://::::::::::::::----------..-:....`.../- -+oo/  ',
                \ '            -/:::-:::::---://:-::-::::----::---.-.......`-/.      `` ',
                \ '           s-`::--:::------:////----:---.-:::...-.....`./:           ',
                \ '          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`            ',
                \ '         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-               ',
                \ '        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                 ',
                \ '                        .-:mNdhh:.......--::::-`                     ',
                \ '                           yNh/..------..`                           ',
                \ '                                                                     ',
                \ '                                                                     ',
                \ '                           E V I L · V I M                           ',
                \ '                                                                     ',
                \ '                                                                     ',
                \ '            [S]essions · [R]ecents · [F]iles · [N]otewiki            ',
                \ '                                                                     ',
                \ '                                                                     ',
                \ ]
    
    let header = exists('g:startscreen_custom_header')
                \ ? s:set_custom_section(g:startscreen_custom_header)
                \ : s:set_custom_section(g:startscreen_default_header)
    
    let g:startscreen_header = startscreen#center(header)
    
    " add blank line
    if !empty(g:startscreen_header) | let g:startscreen_header += [''] | endif
    call append('$', g:startscreen_header)
    
    setlocal nomodifiable nomodified  " No modifications to this buffer
    set filetype=startscreen
    
    nnoremap <buffer><nowait><silent> s :CocList sessions<cr>
    nnoremap <buffer><nowait><silent> r :CocList mru<cr>
    nnoremap <buffer><nowait><silent> f :CocList files<cr>
    nnoremap <buffer><nowait><silent> n :NoteWikiIndex<cr>
endfunction
