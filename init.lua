vim.cmd ("source ~/.vimrc")
vim.cmd ("set mouse=a")

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
         require("lspconfig").rust_analyzer.setup{} -- Configure for your specific language server
       end,
    },
	{
	    "williamboman/mason.nvim"
	},
	'voldikss/vim-floaterm',
	"rafamadriz/friendly-snippets",
	'hrsh7th/nvim-cmp', -- Autocompletion plugin
  	'hrsh7th/cmp-buffer', -- Buffer completions
  	'hrsh7th/cmp-path', -- Path completions
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp', -- LSP source for
	'hrsh7th/cmp-nvim-lsp-signature-help',  -- Signature help source for nvim-cmp
    'nvim-tree/nvim-web-devicons',
	{
		'nvimdev/lspsaga.nvim',
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
    'nvim-tree/nvim-tree.lua',
    'VundleVim/Vundle.vim',
    '42Paris/42header',
    'LunarWatcher/auto-pairs',
    'tpope/vim-surround',
    'christoomey/vim-tmux-navigator',
    "nvim-treesitter/nvim-treesitter",
    'simrat39/rust-tools.nvim',
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
settings = {
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true
        },
        checkOnSave = {
            command = "clippy"
        },
        rustfmt = {
            enableRangeFormatting = true
        }
    }
}
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
 }

-- Enable LSP for rust-analyzer with nvim-lspconfig
require("lspconfig").clangd.setup{} -- Configure for your specific language server
require("lspconfig").ols.setup{} -- Configure for your specific language server
local nvim_lsp = require('lspconfig')

require('rust-tools').setup({})

nvim_lsp.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"  -- This ensures Clippy runs automatically on save
            }
        }
    },
    on_attach = function(client, bufnr)
        -- Mappings for LSP
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- LSP mappings (example)
        local opts = { noremap=true, silent=true }
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "rust", "lua", "vim", "vimdoc", "query", "html", "typescript", "odin"},
  sync_install = false,
  highlight = {
    enable = true,
  },
}

require("nvim-web-devicons")

require("nvim-tree").setup()
require'nvim-web-devicons'.get_icons()


vim.api.nvim_set_hl(0, '@variable.member.typescript', { fg = '#f0f0f0', bold = true })
vim.api.nvim_set_hl(0, '@function.method.call.typescript', { fg = '#aafaaa', bold = true })

vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, '@lsp.type.function', { fg = '#FFaaaa', bold = true })
-- Require LuaSnip
local ls = require("luasnip")

local saga = require('lspsaga')

saga.setup{
	lightbulb = {
		enable = false,
	},
}

local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Optional: disable tsserver formatting in favor of a dedicated formatter
    client.server_capabilities.document_formatting = false

    -- Keybindings for LSP (add more as needed)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
    client.server_capabilities.documentFormattingProvider = false -- if using a separate formatter like Prettier
  end,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = function(client)
  end,
  root_dir = require('lspconfig').util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
})
local lspconfig = require('lspconfig')


local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
    }, {
      { name = 'buffer' },
    })
  })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
})


require("mason").setup{}

-- Tailwind CSS language server setup
lspconfig.tailwindcss.setup({
  filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          "tw`([^`]*)", -- For Tailwind `tw` usage
          'tw="([^"]*)', -- For inline Tailwind classes
        }
      }
    }
  }
})
-- Use 'K' for LSP hover documentation
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
require("lspconfig").html.setup{} -- Configure for your specific language server
require("luasnip.loaders.from_vscode").lazy_load()

vim.cmd([[ autocmd FileType typescriptreact lua require("luasnip").filetype_extend("typescriptreact", { "html" }) ]])
