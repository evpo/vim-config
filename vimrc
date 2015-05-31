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
command Help execute "echo 'commands: EnableSpell, DisableSpell, HL, Help'"
command HL execute "call g:ClangUpdateQuickFix()"
nnoremap <kMinus> <C-U>
nnoremap <kPlus> <C-D>
inoremap jj <ESC>
nnoremap <F12> <C-]>
nnoremap <C-_> <C-T>

"In putty you need to disable Ctrl S. Add these lines to your .bashrc:
"stty ixany
"stty ixoff -ixon
nnoremap <C-s> :w<CR>
