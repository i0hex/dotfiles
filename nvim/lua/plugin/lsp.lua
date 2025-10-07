-- mason configurations
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
    ensure_installed = { "lua_ls", "pyright", "clangd", "neocmake", "rust_analyzer" },
    automatic_enable = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach_signature = function(client, bufnr)
	require('lsp_signature').on_attach({
		bind = true,
		hint_prefix = "➜",
		floating_window = true,
		max_width = 80,
	}, bufnr)
end


vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

vim.lsp.config('clangd', {
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

vim.lsp.config('neocmake', {
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  on_attach = on_attach_signature,
})
