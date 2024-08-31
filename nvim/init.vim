" Remap leader key
let mapleader = " "
let maplocalleader = " "

" Don't add to clipboard with deleting with x
vnoremap x "_x

" Yank to system clipboard
nnoremap <leader>y "+y
xnoremap <leader>y "+y

" Paste from system clipboard
nnoremap <leader>p "+p
xnoremap <leader>p "+p

" Map Tab to indent current line or selected lines
nnoremap <Tab> >>
nnoremap <S-Tab> <<
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" Move text up and down
vnoremap J :m .+1<CR>==
vnoremap K :m .-2<CR>==
xnoremap J :move '>+1<CR>gv-gv
xnoremap K :move '<-2<CR>gv-gv

" Paste without overwriting clipboard
vnoremap p "_dP