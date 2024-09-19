vim.cmd ("source ~/.vimrc")
vim.cmd ("set mouse=a")
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.diagnostic.config({
  virtual_text = true,  -- This disables inline diagnostics
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "neovim/nvim-lspconfig",
		after = "nvim-lspconfig",
			config = function()
			require("lspconfig").clangd.setup{} -- Configure for your specific language server
		end,
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
	'nvim-tree/nvim-web-devicons',     -- optional
    'nvim-tree/nvim-tree.lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'VundleVim/Vundle.vim',
    '42Paris/42header',
    'LunarWatcher/auto-pairs',
    'tpope/vim-surround',
    'christoomey/vim-tmux-navigator',
	'onsails/lspkind-nvim',
	"glepnir/lspsaga.nvim",
    'tpope/vim-fugitive',
	'simrat39/rust-tools.nvim',
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {
	  },
	  keys = {
		{
		  "<leader>?",
		  function()
			require("which-key").show({ global = false })
		  end,
		  desc = "Buffer Local Keymaps (which-key)",
		},
	  },
	},
    { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
	{
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {},
			config = function(_, opts) require'lsp_signature'.setup(opts) end
		}
	}
})
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
require'lspconfig'.tsserver.setup {}
local nvim_lsp = require('lspconfig')

require("lsp_signature").setup({
  bind = true,
  floating_window = true,
  hint_enable = false, -- Disable hinting if you prefer
})
nvim_lsp.clangd.setup{}
nvim_lsp.lua_ls.setup{}
nvim_lsp.rust_analyzer.setup{}
nvim_lsp.html.setup({
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach() -- Optional: Attach signature help
  end,
})

-- Setup Emmet language server
nvim_lsp.emmet_ls.setup({
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach() -- Optional: Attach signature help
  end,
  filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
})local cmp = require'cmp'

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


cmp.setup({
  -- Enable LSP completion sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },

  -- Additional configuration...
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
require'luasnip'.config.setup({
  expand_on_enter = false,
})
  local cmp = require'cmp'
  -- Set up lspconfig.
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "rust"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    enable = true,
  },
}

-- TypeScript/JavaScript LSP setup
nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    -- Enable signature help
    require('lsp_signature').on_attach()
  end
})
require('lspsaga').setup({
  definition_preview_icon = '  ',
  border_style = "single",
  rename_prompt_prefix = '➤',
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  lightbulb = {
	  enable = false,
  }
})

-- Keybindings
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', { noremap = true, silent = true })
require("nvim-web-devicons")

require'nvim-web-devicons'.get_icons()

-- disable netrw at the very start of your init.lua

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      -- ... setup options here ...
    }, bufnr)
  end,
})

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()
