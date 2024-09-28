return {
    'stevearc/conform.nvim',
    ft = {"python"},
    opts = {},
    config = function ()
        require("conform").setup({
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            format_on_save = {
                lsp_fallback = true,
            },
        })
    end
}
