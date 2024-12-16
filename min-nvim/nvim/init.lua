vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Basic character settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = ' ' }

-- Tab configuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
            
-- Set clipboard to system
vim.opt.clipboard = 'unnamedplus'

-- Prevent line-break
vim.o.textwidth = 0 -- prevent line-breaks
vim.o.wrap = false  -- displays lines as a single line

-- Auto-close brackets
--vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true })
--vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true })
--vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
--vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })
--vim.api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true })


-- Map <Leader>x to close the current buffer
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<Leader>x', ':bd<CR>', { noremap = true, silent = true })


-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------------- Plugins setup begins from here ------------------------------------------------------------------

-- Load lazy.nvim (make sure lazy.nvim is installed)
-- You can use this bootstrap code for lazy.nvim if you haven't done so already
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Setup lazy.nvim to handle plugins
require("lazy").setup({
  -- Add plugins here, including Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Telescope depends on plenary.nvim
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "%.git/"},
            }
        })
   end
  },
  {
      "stevearc/oil.nvim",
      config = function()
          require("oil").setup({
              default_file_explorer = true,
              --columns = { "icon", "permissions", "size", "mtime" },
              delte_to_trash = true,
              preview = { update_on_cursor_moved = true },
              view_options = { show_hidden = true, }
          })
--       vim.cmd("highlight Normal guibg=#15141B")
      end
  },
  --{ "rose-pine/neovim", 
    --name = "rose-pine",
    --config = function()
        --require('rose-pine').setup({
          --  variant = "moon",
          --  highlight_groups = {
         --      Comment = { italic=false }
       --     }
     --  })
   --     vim.cmd("colorscheme rose-pine-moon")
 --  end
  --},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
            },
            ensure_installed = { "lua", "javascript", "typescript", "html", "css", "java" }
        })
    end
  },
  -- Themes exploring
  {
      "rebelot/kanagawa.nvim",
      priority = 1000,
  },
})


-- Kanagawa setup
require("kanagawa").setup({
    commentStyle = { italic = false },
    functionStyle = { italic = false },
    keywordStyle = { italic = false },
    terminalColors = true,
    theme = dragon,
})
vim.cmd("colorscheme kanagawa-dragon")

-- Set Background color with Aura hex0value
vim.opt.termguicolors = true

--vim.cmd("highlight Normal guibg=#15141B")
--vim.cmd("highlight String guifg=#2EBF7E")

vim.cmd([[
    highlight Normal guibg=#0f0e0e
    highlight LineNr guibg=#0f0e0e
    highlight CursorLineNr guibg=#0f0e0e
    highlight String guifg=#7092bf
]])

-- Telescope Keybindings
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })


-- Oil keybindings
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

-- Move between Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
    ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'jdtls'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                on_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
        end,
    },
})

require('lspconfig').jdtls.setup({
    cmd = { 'jdtls' },
    on_attach = lsp_attach,
    root_dir = require('lspconfig.util').root_pattern('.git', 'pom.xml', 'build.gradle'),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2a2a32", fg = "#e0def4" })       -- Popup menu background
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#403d52", fg = "#e0def4" })   -- Selected item in popup menu
vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#c3c2d4" })                -- Non-selected item text
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#9ccfd8" })           -- Matched text
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#f6c177" })                -- Item kind (e.g., function, variable)
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#907aa9" })                -- Item source (e.g., LSP, buffer)

-- Telescope custom highlights to match `rose-pine` theme
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#2a2a32", fg = "#e0def4" })       -- Background and text color
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#2a2a32", fg = "#403d52" })       -- Border color
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#f6c177", bold = true })     -- Prompt title color
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#9ccfd8", bold = true })    -- Results title color
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#e0def4", bold = true })    -- Preview title color
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#403d52", fg = "#e0def4" })    -- Selected item background
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#f6c177", bold = true })        -- Matching characters color
