**My Vim Ssettings**

1. Checkout to `~/vimfiles`
2. Create `~/.vimrc` file with the following:

```
runtime vimrc
nnoremap <kMinus> <C-U>
nnoremap <kPlus> <C-D>
inoremap jj <ESC>
```

The lines above are for Qt Creator

Configure cscope `set csprg=<path to cscope executable>`
