" TODO: switch dotfiles to default platform path
" TODO: install vim-plug elsewhere
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')

" colorscheme
Plug 'morhetz/gruvbox'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" dev
Plug 'preservim/nerdtree'

"Plug 'tpope/vim-fugitive'
"Plug 'kien/ctrlp.vim'

"Plug 'neovim/nvim-lsp'
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'

"Plug 'github/copilot.vim'
call plug#end()

colorscheme gruvbox

set autochdir
nnoremap <C-n> :tabdo NERDTreeToggle \| :wincmd p<cr>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror \| wincmd p | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close NERDTree on open
let NERDTreeQuitOnOpen=1

"" Enable Tab / Shift Tab to cycle completion options
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"let g:completion_enable_fuzzy_match = 1
"set completeopt=menuone,noinsert,noselect

"lua << EOF
"require'lspconfig'.pylsp.setup{}
"EOF
