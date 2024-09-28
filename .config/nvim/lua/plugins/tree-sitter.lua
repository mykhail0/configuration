return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "vimdoc",
                "awk", "bash",
                "c", "cpp", "rust", "llvm",
                "java", "haskell",
                "python", "lua",
                "javascript", "typescript",
                "html", "css",
                "json", "toml",
                "make", "cmake",
                "markdown", "latex"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                --additional_vim_regex_highlighting = false,
            },
            --indent = { enable = true },  
        })
    end
}
