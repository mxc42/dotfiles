" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'bluz71/vim-moonfly-colors'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'masawada/completor-dictionary'
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()

let g:completor_clang_binary = '/usr/bin/clang'
set timeoutlen=150

" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

autocmd FileType md execute 'setlocal dictionary='.expand($HOME.'/.vim/dict/'.&filetype.'.dict')

colorscheme elflord
set visualbell t_vb=
set number
