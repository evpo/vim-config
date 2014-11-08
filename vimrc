set nocompatible
syntax on
set ignorecase
set number
filetype indent on
set shiftwidth=4
set tabstop=4
set expandtab
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set background=dark
highlight lCursor guifg=NONE guibg=Cyan
command EnableSpell execute "setlocal spell spelllang=ru_ru,en_us"
command DisableSpell execute "setlocal spell!"
