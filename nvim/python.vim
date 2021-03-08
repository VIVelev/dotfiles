"Python Host Program
if !empty($VIRTUAL_ENV)
    let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python'
else
    let g:python3_host_prog = '~/.pyenv/shims/python'
endif
