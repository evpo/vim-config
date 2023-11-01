call NERDTreeAddKeyMap({
       \ 'key': '<F5>',
       \ 'callback': 'NERDTreeHbopenHandler',
       \ 'quickhelpText': 'echo call hb-start <file>',
       \ 'scope': 'FileNode' })

function! NERDTreeHbopenHandler(dirnode)
    let treenode = g:NERDTreeFileNode.GetSelected()
    if treenode != {}
        call system("hb-open '" . treenode.path.str() . "' &")
    endif
endfunction

