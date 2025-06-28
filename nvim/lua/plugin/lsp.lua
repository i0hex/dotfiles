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
    ensure_installed = { "lua_ls", "pyright", "clangd", "neocmake" },
    automatic_enable = true,
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach_signature = function(client, bufnr)
	require('lsp_signature').on_attach({
		bind = true,
		hint_prefix = "➜",
		floating_window = true,
		max_width = 80,
	}, bufnr)
end


lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

lspconfig.neocmake.setup({
  capabilities = capabilities,
  on_attach = on_attach_signature,
})

