-- LSP
local lsp = require("lsp-zero")

lsp.preset("recommended")

-- lsp.on_attach(function(client, bufnr)
--     local caps = client.server_capabilities
--     if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
--         local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
--         vim.api.nvim_create_autocmd("TextChanged", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--                 vim.lsp.buf.semantic_tokens_full()
--             end,
--         })
--         -- fire it first time on load as well
--         vim.lsp.buf.semantic_tokens_full()
--     end
--     --...
-- end)

lsp.set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end
})

lsp.setup()
