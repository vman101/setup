vim.cmd ("source ~/.vimrc")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.cmd ("set mouse=a")
vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    {"neovim/nvim-lspconfig",
    after = "nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup{} -- Configure for your specific language server
    end,
  },
  -- lspsaga.nvim
 'hrsh7th/cmp-nvim-lsp',
    'nvimdev/lspsaga.nvim',
    'hrsh7th/cmp-buffer',
 'hrsh7th/cmp-path',
 'hrsh7th/cmp-cmdline',
 'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
   'saadparwaiz1/cmp_luasnip',
	'VundleVim/Vundle.vim',
	'42Paris/42header',
	'sheerun/vim-polyglot',
	'preservim/nerdtree',
	'HealsCodes/vim-gas',
	'LunarWatcher/auto-pairs',
	'tpope/vim-surround',
	'christoomey/vim-tmux-navigator',
	'navarasu/onedark.nvim',
	'tpope/vim-fugitive',
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },

})
require("lazy").setup(plugins, opts)
require('lspsaga').setup({})
require'luasnip'.config.setup({
  expand_on_enter = false,
})
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      --completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = function(fallback)
        if cmp.visible() then
          cmp.select_confirm()
        else
          fallback()
        end
      end,
      select = false
    }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
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
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
  },
}
