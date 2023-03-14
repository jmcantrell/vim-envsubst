set rtp^=.

set pp^=./tests/.vim
set pp+=./tests/.vim/after

filetype plugin on

command PressKeyNext :execute $"normal {g:envsubst_trigger_next}"
command PressKeyPrev :execute $"normal {g:envsubst_trigger_prev}"
