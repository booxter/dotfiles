"syntax on
"set nu ru et
"set ts=2 sts=2 sw=2
"set cursorline
"set hlsearch

"set nocompatible   " be improved, required
"filetype off       " required

" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" TODO: switch dotfiles to default platform path
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
"Plug 'tpope/vim-fugitive'
"Plug 'preservim/nerdtree'
"Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

" autocmd VimEnter * GoInstallBinaries

"" Mirror the NERDTree before showing it. This makes it the same on all tabs.
"map <silent> <C-n> :NERDTreeFocus<CR>

"" Enable Tab / Shift Tab to cycle completion options
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"let g:completion_enable_fuzzy_match = 1
"set completeopt=menuone,noinsert,noselect

"lua << EOF
"require'lspconfig'.pylsp.setup{}
"EOF
