syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch

set nocompatible   " be improved, required
filetype off       " required

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

colorscheme gruvbox

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
map <silent> <C-n> :NERDTreeFocus<CR>
