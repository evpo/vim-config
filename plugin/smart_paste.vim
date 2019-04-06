" Smart paste
" It pastes the content of the register and inserts it as a word between other
" words

function! StripL(input)
    return substitute(a:input, '^\s*\(.*\)', '\1', 'g')
endfunction

function! StripR(input)
    return substitute(a:input, '\(.*\)\s$', '\1', 'g')
endfunction

function! SmartPasteFindVariant(line, col)
    let line=a:line
    let line_len=strlen(line)
    let col=a:col
    let var=0
    let ch = line[col - 1 : col - 1]
    if (line_len <= 1 && (ch == " " || ch == ""))
        let var = 6
    elseif (col == 1)
        let var = 1
    elseif (col == line_len)
        let var = 2
    endif

    if (var != 0)
        return var
    endif

    let ch_left = line[col - 2 : col - 2]
    let ch_right = line[col : col]
    if (ch == " ")
        let var = 5
    elseif (ch_left == " ")
        let var = 3
    elseif (ch_right == " " && col + 1 == line_len)
        " one tw>o[ ]
        let var = 2
    elseif (ch_right == " " && col + 1 != line_len)
        let var = 4
    endif

    return var
endfunction

function! SmartPaste()
"1
">one
"2
"on>e
"3
"one >two"
"4
"on>e two"
"5
"one> two"
"6
">[ ]

    let line = getline(".")
    let col = col(".")
    let var = SmartPasteFindVariant(line, col)
    if ( var == 4 || var == 5)
        execute "normal! w"
        let var = 3
        let col = col(".")
    endif

    if (var == 1)
        let left=""
        let right=line
    elseif (var == 2)
        let left=StripR(line)
        let right=""
    elseif (var == 3)
        let left=line[:col-2]
        let right=line[col-1:]
    elseif (var == 6)
        let left=""
        let right=""
    else
        return
    endif
    let left=StripR(left)
    let right=StripL(right)
    " strip empty space at the start and empty space and cr at the end
"    echo "line=[" . line . "]"
"    echo "left=[" . left . "]"
"    echo "right=[" . right . "]"
    let reg=@"
    let strip_reg=substitute(reg, '^ \?\(.\{-}\) \?\n\?$', '\1', 'g')
    if (var != 1 && var != 6)
        let left = left . " "
    endif
    if (var != 2 && var != 6)
        let right = " " . right
    endif
    call setline(".", left . strip_reg . right)
endfunction
