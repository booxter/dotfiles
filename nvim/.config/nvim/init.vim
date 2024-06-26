" TODO: switch dotfiles to default platform path
" TODO: install vim-plug elsewhere
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')

" auto-refocus
Plug 'nvim-focus/focus.nvim'

" colorscheme
Plug 'morhetz/gruvbox'

" terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" dev
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'github/copilot.vim'
Plug 'christoomey/vim-tmux-navigator', { 'lazy': 'false' }
Plug 'metakirby5/codi.vim'

Plug 'MunifTanjim/nui.nvim'
Plug 'piersolenski/wtf.nvim'

Plug 'kevinhwang91/promise-async'

Plug 'ray-x/lsp_signature.nvim'

Plug 'RaafatTurki/corn.nvim'

" smooth scroll
"Plug 'karb94/neoscroll.nvim'

" langs
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sheerun/vim-polyglot'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'

"Plug 'preservim/vim-markdown'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'epwalsh/obsidian.nvim'

call plug#end()

colorscheme gruvbox

" NERDTree
nnoremap <C-n> :tabdo NERDTreeToggle \| :wincmd p<cr>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror \| wincmd p | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close NERDTree on open
let NERDTreeQuitOnOpen=1

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"" Enable Tab / Shift Tab to cycle completion options
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use ESC in terminal
tnoremap <Esc> <C-\><C-n>

" Maximize and unmaximize with C-W + o
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" yank to system buffer by default
set clipboard=unnamedplus

" apparently needed for obsidian plugin
set conceallevel=1

" rebalance pane sizes on terminal size change
autocmd VimResized * wincmd =

set number
set relativenumber

let g:codi#interpreters = {
      \ 'python': {
          \ 'bin': 'python3',
          \ },
      \ }


lua << EOF
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

require('gitsigns').setup()

require'lspconfig'.pylsp.setup{}
require'lspconfig'.gopls.setup{}

require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
require'toggleterm'.setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  direction = 'vertical',
  close_on_exit = true, -- close the terminal window when the process exits
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
}
require'lsp_signature'.setup()
require'corn'.setup()
require("focus").setup()
require("wtf").setup()
require("obsidian").setup({
  workspaces = {
    {
      name = "notes",
      path = "~/notes",
    },
  },
})
EOF
