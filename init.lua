vim.cmd ("source ~/.vimrc")
vim.cmd ("set mouse=a")
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
      "neovim/nvim-lspconfig",
       after = "nvim-lspconfig",
       config = function()
         require("lspconfig").clangd.setup{} -- Configure for your specific language server
         require("lspconfig").rust_analyzer.setup{} -- Configure for your specific language server
       end,
    },
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-buffer', -- Buffer completions
  'hrsh7th/cmp-path', -- Path completions
  'hrsh7th/cmp-nvim-lsp', -- LSP source for
	'hrsh7th/cmp-nvim-lsp-signature-help',  -- Signature help source for nvim-cmp
    'nvim-tree/nvim-web-devicons',
    'nvimdev/lspsaga.nvim',
    'nvim-tree/nvim-tree.lua',
    'VundleVim/Vundle.vim',
    '42Paris/42header',
    'LunarWatcher/auto-pairs',
    'tpope/vim-surround',
    'christoomey/vim-tmux-navigator',
    "nvim-treesitter/nvim-treesitter",
	"puremourning/vimspector",
	    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  'nvim-lua/plenary.nvim' ,
'ThePrimeagen/harpoon'  , 
'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }}
	  )
local nvim_lsp = require('lspconfig')
nvim_lsp.rust_analyzer.setup {
  on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,
  settings = {
    ["rust-analyzer"] = {}
  }
}
require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
})
require("telescope").load_extension('harpoon')
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "rust", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer

  highlight = {
    enable = true,
  },
}

require("nvim-web-devicons")

require("nvim-tree").setup()
require'nvim-web-devicons'.get_icons()

-- disable netrw at the very start of your init.lua

-- Setup nvim-cmp

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
		{ name = 'nvim_lsp_signature_help' },  -- Signature help
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
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
-- Setup lspconfig
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
-- optionally enable 24-bit colour
vim.opt.termguicolors = true
