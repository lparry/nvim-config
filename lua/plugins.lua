-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'lparry/file-line'
  use 'lparry/vim-paste-over'
  use 'lparry/vim-rspec-jump'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive' -- git integrations
  use 'tpope/vim-rhubarb' -- github integrations (GBrowse)
  use 'tpope/vim-surround' -- adds surround movement commands
  use 'tpope/vim-ragtag' -- Enhances ^^ surround.vim to support more languages
  use 'tpope/vim-repeat' -- lets . interact with plugin maps
  use 'tpope/vim-eunuch' -- Vim sugar for unix shell commands
  use 'tpope/vim-rsi' -- readline style insertion

  -- use 'tpope/vim-rails' -- Rails vim stuff
  use 'tpope/vim-vinegar' -- Better netrw file navigation
  use 'simnalamburt/vim-mundo' -- fancy undo history navigation
  use 'conradirwin/vim-bracketed-paste' -- Make vim's paste less shit
  use 'hail2u/vim-css3-syntax'
  use 'vim-scripts/ShowTrailingWhitespace'
  use 'jparise/vim-graphql'

  -- use 'slim-template/vim-slim'
  use 'onemanstartup/vim-slim'

  -- use 'janko/vim-test'
  -- use 'keith/swift.vim'
  -- use 'udalov/kotlin-vim'

  -- JS plugins
  -- use 'MaxMEllon/vim-jsx-pretty' --vim jsx highlighting
  use 'pangloss/vim-javascript'
  use 'elzr/vim-json'
  -- use 'editorconfig/editorconfig-vim'
  -- use 'gpanders/editorconfig.nvim'
  -- use 'sgur/vim-editorconfig'

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- vim.opt.list = true
      -- vim.opt.listchars:append("space:⋅")
      -- vim.opt.listchars:append("eol:↴")

      -- require("indent_blankline").setup {
      --   space_char_blankline = " ",
      --   show_current_context = true,
      --   show_current_context_start = true,
      -- }
      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

      vim.opt.list = true
      -- vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")

      require("indent_blankline").setup {
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end
  }

  use {
    'ruby-formatter/rufo-vim',
    config = function()
      local k = require('util.keymap')
      k.nnoremap('<leader>rf', ':Rufo<cr>')
    end
  }
  -- use 'romainl/vim-qf'


  ----" Colorschemes
  --use 'nanotech/jellybeans.vim'
  use {
    'metalelf0/jellybeans-nvim',
    requires = "rktjmp/lush.nvim",
  }


  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- unwieldy confg in local file ./lsp.lua
      require('lsp')
    end,
  }

  use {
    'junegunn/fzf.vim',
    requires = '/usr/local/opt/fzf',
    config = function()
      local k = require('util.keymap')
      k.nnoremap('<leader>bu', ':Buffers<CR>', { silent = true })
      k.nnoremap('<leader>FI', ':Files<CR>', { silent = true })
      k.nnoremap('<leader>fi', ':GitFiles<CR>', { silent = true })
      k.nnoremap('<leader>rw', ':exec "Rg " . expand("<cword>")<cr>', { silent = true })
      k.nnoremap('<leader>rg', ':Rg ')
    end,
  }

  use {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require('lsp-format').setup { }
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup { }
    end
  }

  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = {
      { 'ms-jpq/coq.artifacts', branch = 'artifacts'},
      { 'ms-jpq/coq.thirdparty', branch = '3p'},
    },
    setup = function()
      local k = require('util.keymap')
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        keymap = {
          recommended = false,
        },
      }
    end,
    config = function()
      vim.cmd [[
        " ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
        ino <silent><expr> <Esc>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Esc>" : "\<C-y><Esc>") : "\<Esc>"
        ino <silent><expr> <Right>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Right>" : "\<C-y>") : "\<Right>"
        ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
        ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
        ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
        ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

      ]]
    end
  }

  -- use {
  --   'hrsh7th/nvim-cmp',
  --   requires = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-cmdline',
  --     'hrsh7th/nvim-cmp',
  --     'hrsh7th/cmp-vsnip',
  --     'hrsh7th/vim-vsnip',
  --   },
  --   config = function()
  --      local cmp = require'cmp'

  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --         end,
  --       },
  --       sources = cmp.config.sources({
  --           { name = 'nvim_lsp' },
  --           { name = 'vsnip' }, -- For vsnip users.
  --           { name = 'buffer' },
  --       }),
  --       mapping = {
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif vim.fn["vsnip#available"](1) == 1 then
  --             feedkey("<Plug>(vsnip-expand-or-jump)", "")
  --           -- elseif has_words_before() then
  --           --   cmp.complete()
  --           else
  --             fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  --           end
  --         end, { "i", "s" }),

  --         ["<S-Tab>"] = cmp.mapping(function()
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif vim.fn["vsnip#jumpable"](-1) == 1 then
  --             feedkey("<Plug>(vsnip-jump-prev)", "")
  --           end
  --         end, { "i", "s" }),
  --         ['<Enter>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  --         ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  --         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  --         -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  --         -- ['<C-e>'] = cmp.mapping({
  --         --   i = cmp.mapping.abort(),
  --         --   c = cmp.mapping.close(),
  --         -- }),
  --       },
  --     })

  --     -- local k = require('util.keymap')
  --     -- k.imap("<tab>", function()
  --     --   cmp.mapping.confirm({ select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --     --   return ''
  --     -- end)
  --   end
  -- }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        auto_close = true,
        mode = "document_diagnostics",
        auto_jump = {"lsp_definitions"},
        auto_open = false, -- automatically open the list when you have diagnostics
        signs = {
          -- icons / text used for a diagnostic
          error = "🛑",
          warning = "⚠️",
          hint = "💡",
          information = "ℹ️",
          other = "✅"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      }

      local k = require('util.keymap')
      -- k.nnoremap("<leader>xx", "<cmd>Trouble<cr>", { silent = true })
      -- k.nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
      -- k.nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
      -- k.nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true })
      -- k.nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true })
      -- k.nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true })
      -- k.nnoremap("gd", "<cmd>TroubleToggle lsp_definitions<cr>", { silent = true })

      k.nnoremap('<leader>an', function()
        require("trouble").next({skip_groups = true, jump = true});
        return ''
      end)

      k.nnoremap('<leader>ap', function()
        require("trouble").previous({skip_groups = true, jump = true});
        return ''
      end)
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require("lualine").setup {
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'filename', path = 1, file_status = true } },
          lualine_c = { }, --'branch', { "diagnostics", sources = { "nvim_lsp" } } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
          virt_text_pos = 'eol'
        },
        -- word_diff = true,
        signs = {
          add = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        sign_priority = 1,
      }
      vim.cmd [[ set signcolumn=auto:1-2 ]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = {
          "javascript",
          "typescript",
          "tsx",
          "bash",
          "lua",
          "graphql",
          "css",
          "html",
          "java",
          "json",
          "json5",
          "jsonc",
          "kotlin",
          "markdown",
          "ruby",
          "vim",
          "yaml",
        },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        indent = {
          enable = true,
          disable = { "ruby" },
        },

        highlight = {
          enable = true,
        }
      }
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.shellcheck
        },
      }
    end
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  vim.api.nvim_exec([[
    augroup Plugins
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      autocmd BufWritePost plugins.lua PackerClean
      autocmd BufWritePost plugins.lua PackerInstall
    augroup end
    ]], false)


end)

