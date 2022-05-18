local nvim_lsp = require('lspconfig')

local coq = require("coq") -- add this

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- vim.lsp.set_log_level("debug")

local on_attach = function (client, bufnr)
  require "lsp-format".on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- -- autoformat on save, but sync so there's an awful delay
  -- if client.resolved_capabilities.document_formatting then
  --   -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
  --   vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  --   -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)]]
  -- end
end

-- nvim_lsp.kotlin_language_server.setup{
--   cmd = { "/Users/david/Downloads/server/bin/kotlin-language-server" },
--   on_attach = on_attach,
-- }

nvim_lsp.sorbet.setup(coq.lsp_ensure_capabilities({
  cmd = { "srb", "tc", "--lsp" },
  -- absurdly verbose logging
  -- cmd = { "srb", "tc", "--lsp", "-vvv" },
  root_dir = nvim_lsp.util.root_pattern("sorbet"),
  on_attach = on_attach,
  -- capabilities = capabilities,
}))

-- nvim_lsp.solargraph.setup({
--   cmd = { "solargraph", "stdio" },
--   filetypes = { "ruby" },
--   init_options = { formatting = false },
--   root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git"),
--   settings = {
--     solargraph = {
--       diagnostics = true
--     }
--   }
-- })

nvim_lsp.flow.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  on_new_config = function (new_config, new_root_dir)
    new_config.cmd = { new_root_dir .. "/node_modules/.bin/flow", "lsp" }
  end,
  -- capabilities = capabilities,
}))

nvim_lsp.tsserver.setup(coq.lsp_ensure_capabilities({

  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = function (client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
  end,
  -- capabilities = capabilities,
}))

nvim_lsp.rls.setup({
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end,
})

nvim_lsp.sourcekit.setup {
  on_attach = on_attach,
}

nvim_lsp.diagnosticls.setup {
  filetypes = { "ruby", "javascript", "typescript", "typescriptreact", "sh", "bash", "zsh" },
  -- this needs to be kept up to date with all the rootPatterns below
  root_dir = nvim_lsp.util.root_pattern(".git"),
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end,
  init_options = {
    filetypes = {
      javascript = { "eslint", "prettier" },
      typescript = { "eslint", "prettier" },
      typescriptreact = { "eslint", "prettier" },
      -- ruby = { "rubocop", "prettier" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" },
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity",
        },
        securities = {
          [2] = "error",
          [1] = "warning",
        },
      },
      rubocop = {
        sourceName = "rubocop",
        rootPatterns = { ".rubocop.yml" },
        command = "rubocop",
        args = {
          "--stdin",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "files.[0].offenses",
          line = "location.start_line",
          column = "location.start_column",
          endLine = "location.last_line",
          endColumn = "location.last_column",
          message = "${message} [${cop_name}]",
          security = "severity",
        },
        securities = {
          fatal = "error",
          error = "error",
          warning = "warning",
          convention = "info",
          refactor = "info",
          info = "info",
        },
      },
      shellcheck = {
        command = "shellcheck",
        debounce = 100,
        args = { "-x", "--format", "json", "-" },
        sourceName = "shellcheck",
        parseJson = {
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${code}]",
          security = "level"
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "info",
          style = "hint",
        },
      },
    },
    formatFiletypes = {
      javascript = { "prettier","eslint_d" },
      typescript = { "prettier","eslint_d" },
      typescriptreact = { "prettier","eslint_d" },
      ruby = { "rubocop", "prettier" }
    },
    formatters = {
      eslint_d = {
        command = "eslint_d",
        args = { "--stdin", "--fix-to-stdout", "--stdin-filename", "%filepath" },
        isStdout = true,
        doesWriteToFile = false,
      },
      prettier = {
        command = './node_modules/.bin/prettier',
        rootPatterns = { ".prettierrc.json", ".prettierrc" },
        args = { '--stdin-filepath', '%filename' },
      },
    }
  },
}
