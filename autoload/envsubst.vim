let s:variable_pattern = '\c\$\([_a-z][_a-z0-9]\+\)\|\${\([_a-z][_a-z0-9]\{-}\)}'

function! s:get(name, default) abort
    return get(environ(), a:name, a:default)
endfunction

function! s:map(mode, key, plug) abort
    if !hasmapto(a:plug, a:mode)
        execute a:mode.'map '.keytrans(a:key).' '.a:plug
    endif
endfunction

function! envsubst#map_trigger(key, name) abort
    for mode in ['n', 'i', 's']
        call s:map(mode, a:key, '<Plug>EnvSubst'.a:name)
    endfor
endfunction

function! s:find_variable(flags) abort
    let [line, start_column, submatch] = searchpos(s:variable_pattern, a:flags.'p')

    if !line
        return repeat([0], 4)
    endif

    let [_, end_column] = searchpos(s:variable_pattern, 'zce')

    return [line, start_column, end_column, submatch - 1]
endfunction

function! envsubst#substitute() abort range
    execute a:firstline.','.a:lastline.'s/'.s:variable_pattern.'/\=s:get(submatch(1).submatch(2),submatch(0))/g'
endfunction

function! envsubst#select(flags) abort
    let [line, start_column, end_column, capture_group] = s:find_variable(a:flags)

    if !line
        return
    endif

    let s = getline(line)

    echo [line, start_column, end_column, capture_group]

    let before = start_column == 1 ? '' : s[0 : start_column - 2]
    let placeholder = s[start_column - 1 : end_column - 1]
    let after = s[end_column : ]

    let name = substitute(placeholder, s:variable_pattern, '\'.capture_group, '')

    let value = s:get(name, placeholder)

    if value != placeholder
        call setline(line, before.value.after)
        let end_column = start_column + len(value) - 1
    endif

    call setpos('.', [0, line, start_column])
    normal! v
    call setpos('.', [0, line, end_column])
    execute "normal! o\<C-g>"
endfunction
