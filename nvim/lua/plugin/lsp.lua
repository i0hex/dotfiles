--- mason configurations
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

--- mason-lspconfig configurations
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd", "eslint" },
    automatic_enable = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').lua_ls.setup({
  capabilities = capabilities,
})

require('lspconfig').pyright.setup({
  capabilities = capabilities,
})

require('lspconfig').clangd.setup({
  capabilities = capabilities,
})

require('lspconfig').eslint.setup({
  capabilities = capabilities,
})

