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
"nnoremap <S-F12> :tab split<CR>:cs f s <cword><CR>
nnoremap <S-F12> :cs f s <cword><CR>
nnoremap <C-_> <C-T>
map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
"Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
"In putty you need to disable Ctrl S. Add these lines to your .bashrc:
"stty ixany
"stty ixoff -ixon
nnoremap <C-s> :w<CR>
let g:clang_use_library=1
let g:clang_complete_copen=1
let g:clang_library_path='C:/Program Files (x86)/LLVM/bin'
"let g:clang_auto_user_options='compile_commands.json'
"let g:clang_debug=1
set timeoutlen=1000 ttimeoutlen=0
nnoremap '= "+
vnoremap '= "+
