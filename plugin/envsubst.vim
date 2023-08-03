if exists("g:envsubst_loaded")
    finish
endif

let g:envsubst_loaded = 1

command! -range EnvSubst <line1>,<line2>call envsubst#substitute()

nnoremap <silent> <plug>EnvSubstNext :call envsubst#select('c')<cr>
nnoremap <silent> <plug>EnvSubstPrev :call envsubst#select('b')<cr>

inoremap <silent> <plug>EnvSubstNext <esc>:call envsubst#select('c')<cr>
inoremap <silent> <plug>EnvSubstPrev <esc>:call envsubst#select('b')<cr>

snoremap <silent> <plug>EnvSubstNext <esc>:call envsubst#select('')<cr>
snoremap <silent> <plug>EnvSubstPrev <esc>:call envsubst#select('b')<cr>

if exists('g:envsubst_trigger_next')
    call envsubst#map_trigger(g:envsubst_trigger_next, "Next")
endif

if exists('g:envsubst_trigger_prev')
    call envsubst#map_trigger(g:envsubst_trigger_prev, "Prev")
endif
