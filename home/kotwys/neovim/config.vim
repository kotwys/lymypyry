syntax on

set nu
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent smartindent smarttab
set backspace=2

set termguicolors
set guicursor=a:ver25,v:block
set mouse=a

set exrc secure

set backupcopy=yes
set hidden

colorscheme Base2Tone_MotelDark

let g:airline_theme = 'base16'
let g:airline#extensions#tabline#enabled = 1

nmap ; :Denite buffer<CR>
nmap <leader>t :Denite file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:.::!<CR>

function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action') 
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
endfunction

autocmd FileType denite call s:denite_my_settings()

let g:pandoc#folding#fdc=0
let g:pandoc#folding#level=6
let g:pandoc#spell#default_langs=['ru', 'en']
let g:pandoc#formatting#mode='ha'

augroup Languages
  au!
  au BufRead,BufNewFile *.py,*.rs,*.java,*.kt set ts=4 sw=4 sts=4
  au BufRead,BufNewFile *.go set noexpandtab
augroup END

augroup Textual
  au!
  au BufRead,BufNewFile *.md set tw=79 sw=4
augroup END
