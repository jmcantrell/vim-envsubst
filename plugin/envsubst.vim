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

let g:envsubst_trigger_next_default = "\<C-j>"
let g:envsubst_trigger_prev_default = "\<C-k>"

if !exists('g:envsubst_trigger_next')
    let g:envsubst_trigger_next = g:envsubst_trigger_next_default
endif

if !exists('g:envsubst_trigger_prev')
    let g:envsubst_trigger_prev = g:envsubst_trigger_prev_default
endif

if !exists("g:envsubst_no_mappings")
    call envsubst#create_mappings()
endif
