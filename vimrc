call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'mg979/vim-visual-multi'
Plug 'windwp/nvim-autopairs'

" Theme color
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
Plug 'tanvirtin/monokai.nvim'


Plug 'nvim-treesitter/nvim-treesitter', { 'tag': 'v0.9.1', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'kylechui/nvim-surround'

Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip', { 'tag': 'v2.*', 'do': 'make install_jsregexp' }
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'github/copilot.vim'

Plug 'numToStr/Comment.nvim'

" Add plugins to &runtimepath
call plug#end()

" ===========================
" Basic settings
" ===========================
if has('termguicolors')
  set termguicolors
endif
"colorscheme codedark

" The configuration options should be placed before `colorscheme sonokai`.
"let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

" The configuration options should be placed before `colorscheme edge`.
"let g:edge_style = 'aura'
"let g:edge_better_performance = 1
"let g:edge_enable_italic = 0
"let g:edge_disable_italic_comment = 1
"colorscheme edge

"colorscheme monokai_pro
"lua require('monokai').setup { italics = false }


set nocompatible
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif
set fileencoding=utf-8
set number
set ruler
set showcmd
let mapleader = ','
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
set nobackup
set nowritebackup
set noswapfile
"autocmd BufEnter * lcd %:p:h   " Auto change the directory to the current file I'm working on
set showmatch
set incsearch
set hlsearch
" redraws the screen and removes any search highlighting.
nnoremap <silent><expr> <Leader>l (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set autoread
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set complete-=i
set smarttab
set history=1000
set nowrap
set hidden
if has('mouse')
  set mouse=a
endif
set ttimeout
set ttimeoutlen=100
set title

" Fix displaying balloon tip with invalid 'ri' options
"set noballooneval

" a tab is two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab   " use spaces, not tabs

" use the system clipboard as the default register
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

set backspace=indent,eol,start    " backspace through everything in insert mode

set list                          " Show invisible characters
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:>⋅              " a tab should display as ">⋅", trailing whitespace as "⋅"
set listchars+=trail:⋅            " show trailing spaces as middle-dots

" autoflesh changed files
autocmd BufEnter,FocusGained * checktime

" ===========================
" keymap settings
" ===========================
" Remove unwanted spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\t/  /ge<Bar>:let @/=_s<Bar>:nohl<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand("%:p:h")."/"<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resizing vim window splits
nnoremap + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap = <c-w>=
nnoremap < :vertical resize -5<CR>
nnoremap > :vertical resize +5<CR>

" http://tilvim.com/2014/03/18/a-better-paste.html
"map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>


" ===========================
" Utilities
" ===========================
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
map <Leader><Leader> :ZoomToggle<CR>

" Markdown to HTML
" For use it, should download this script(http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip)
" and copy it in /usr/local/bin
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

"set path+=.,src/**,client/**,api/**
"set suffixesadd=.js,.jsx,.ts,.tsx
"function! LoadMainNodeModule(fname)
    "let nodeModules = "./node_modules/"
    "let packageJsonPath = nodeModules . a:fname . "/package.json"

    "if filereadable(packageJsonPath)
        "return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    "else
        "return nodeModules . a:fname
    "endif
"endfunction
"set includeexpr=LoadMainNodeModule(v:fname)


" ===========================
" statusline setup
" ===========================
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        "show status bar

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction


" ===========================
" Plugins settings
" ===========================

" NERDTree configuration
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
map <Leader>n :NERDTreeToggle<CR>
" NERDTree automatically when vim starts up, and cursor start in the other window
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" FZF
nmap <Leader>f :Files<CR>
nmap <Leader>F :Rg<CR>
let g:fzf_preview_window = ['down,60%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9 } }

" Copilot
"imap <silent> <M-j> <Plug>(copilot-next)
"imap <silent> <M-k> <Plug>(copilot-previous)

" nvim-treesitter
lua << EOF
  local treesitter = require 'nvim-treesitter.configs'

  treesitter.setup {
    ensure_installed = { "c", "lua", "vim", "comment", "ruby", "python", "javascript", "typescript", "json", "css", "scss", "html", "markdown" },
    highlight = {
      enable = true
    }
  }
EOF

" nvim-lspconfig and null-ls.nvim
lua << EOF
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider =  true
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local nvim_lsp = require('lspconfig')
  local servers = { 'tsserver', 'solargraph' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
    }
  end
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.diagnostics.eslint_d,
    },
  })

EOF

" luasnip
lua require("luasnip.loaders.from_vscode").lazy_load()

" nvim-cmp
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-CR>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

" nvim-surround
lua require("nvim-surround").setup({})

" nvim-autopairs
lua require("nvim-autopairs").setup {}

" Comment.nvim
lua require('Comment').setup()

" gitsigns.nvim
lua <<EOF
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  })
EOF

" telescope.nvim
"lua << EOF
"require('telescope').setup {
  "defaults = {
    "layout_strategy = 'vertical',
    "layout_config = {
      "vertical = { width = 0.8 }
    "},
  "},
  "extensions = {
    "fzf = {
      "fuzzy = true,                    -- false will only do exact matching
      "override_generic_sorter = true,  -- override the generic sorter
      "override_file_sorter = true,     -- override the file sorter
      "case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       "-- the default case_mode is "smart_case"
    "}
  "}
"}
"-- To get fzf loaded and working with telescope, you need to call
"-- load_extension, somewhere after setup function:
"require('telescope').load_extension('fzf')
"EOF
