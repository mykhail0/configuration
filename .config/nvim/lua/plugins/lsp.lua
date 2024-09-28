return {
    "neovim/nvim-lspconfig",
    ft = {"python"},
    config = function ()
        -- do this only for ft == python
        local lspconfig = require('lspconfig')
        lspconfig.pyright.setup {}
    end,
}
