if exists('g:loaded_startscreen') || &cp | finish | endif

command! Startscreen call startscreen#start()

augroup startscreenstart
    autocmd!
    autocmd VimEnter * Startscreen
augroup END

augroup startscreenstatusline
    autocmd!
    autocmd FileType statusline set laststatus=0 noshowmode noruler
                \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END


let g:loaded_startscreen = 1
let s:save_cpo = &cpo
let &cpo = s:save_cpo

unlet s:save_cpo
set cpo&vim
