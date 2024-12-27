set nocompatible
set autoindent
set showcmd
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set showmatch
set nohlsearch
set expandtab
set showmode
set modeline

" allow copy to clipboard for OSX
" add set mouse=v if you want to copy on drag
" set clipboard=unnamed

" Copy highlighted text in visual mode and hit Ctrl-c to copy. To paste from
" the system clipboard hit Ctrl-v. Uncomment below to enable
" vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

colorscheme murphy
syntax enable
filetype on
filetype plugin on
filetype indent on
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType go set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType yaml,yml,ts,tsc,tsx,sh setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
autocmd FileType json setlocal formatoptions=tcq2l textwidth=78 shiftwidth=2 softtabstop=2 tabstop=8 expandtab