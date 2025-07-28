vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zipPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = ""
vim.opt.timeoutlen = 250
vim.opt.undofile = true

vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.fileformats = "unix,dos"
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.diagnostic.config({
    signs = false,
    virtual_text = true,
})

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
end)

vim.keymap.set("n", "<leader>l", "<cmd>terminal lazygit<CR>")

function Change_CWD(path)
    vim.api.nvim_exec2("wa!", {})
    vim.api.nvim_exec2("%bd!", {})
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.api.nvim_exec2("cd " .. path, {})
    vim.api.nvim_exec2("e .", {})
end

vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>mm", "<cmd>Mason<CR>")
vim.keymap.set("n", "<leader>mc", function() Change_CWD("~/.config/nvim") end)
vim.keymap.set("n", "<leader>mp", function() Change_CWD("~") end)

function Center_Cursor(insert_mode)
    vim.diagnostic.config({ virtual_lines = false })

    local line = vim.api.nvim_win_get_cursor(0)[1]

    if vim.b.last_line == nil then
        vim.b.last_line = line
    end

    if line ~= vim.b.last_line then
        vim.api.nvim_exec2("normal! zz", {})
        vim.b.last_line = line

        if insert_mode then
            vim.fn.cursor({ line, vim.fn.getcurpos()[3] })
        end
    end
end

vim.api.nvim_exec2("autocmd BufEnter * lua Center_Cursor(false)", {})
vim.api.nvim_exec2("autocmd BufWrite * lua vim.lsp.buf.format()", {})
vim.api.nvim_exec2("autocmd CursorMoved * lua Center_Cursor(false)", {})
vim.api.nvim_exec2("autocmd CursorMovedI * lua Center_Cursor(true)", {})
vim.api.nvim_exec2("autocmd TermClose * bd!", {})
vim.api.nvim_exec2("autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no", {})
vim.api.nvim_exec2("autocmd TermOpen * startinsert", {})
vim.api.nvim_exec2("autocmd TextYankPost * lua vim.highlight.on_yank()", {})


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        {
            "saghen/blink.cmp",
            version = "*",
            opts = { signature = { enabled = true } },
        },
        {
            "catppuccin/nvim",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("catppuccin-mocha")
            end,
        },
        {
            "lewis6991/gitsigns.nvim",
            opts = {},
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = { options = { theme = "catppuccin-mocha" } },
        },
        {
            "williamboman/mason.nvim",
            opts = {},
        },
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = { "williamboman/mason.nvim" },
            opts = {
                ensure_installed = {
                    "jdtls",
                    "lua_ls",
                },
            },
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "saghen/blink.cmp",
                "williamboman/mason-lspconfig.nvim",
            },
            config = function()
                vim.lsp.config("lua_ls", {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            }
                        }
                    }
                })

                vim.lsp.enable("biome")
                vim.lsp.enable("clangd")
                vim.lsp.enable("jdtls")
                vim.lsp.enable("jedi_language_server")
                vim.lsp.enable("ruff")
                vim.lsp.enable("rust_analyzer")
            end,
        },
        {
            "folke/noice.nvim",
            dependencies = { "MunifTanjim/nui.nvim" },
            opts = {
                popupmenu = { enabled = false },
                notify = { enabled = false },
                lsp = {
                    progress = { enabled = false },
                    hover = { enabled = false },
                    signature = { enabled = false },
                    message = { enabled = false },
                },
            },
        },
        {
            "stevearc/oil.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            event = "VimEnter",
            opts = function()
                vim.keymap.set("n", "-", "<cmd>Oil<CR>");

                return {
                    delete_to_trash = true,
                    keymaps = {
                        ["<CR>"] = "actions.select",
                        ["<C-c>"] = { "actions.close", mode = "n" },
                        ["-"] = { "actions.parent", mode = "n" },
                        ["_"] = { "actions.open_cwd", mode = "n" },
                        ["~"] = { "actions.cd", mode = "n" },
                    },
                    use_default_keymaps = false,
                    view_options = { show_hidden = true },
                }
            end,
        },
        {
            "folke/snacks.nvim",
            priority = 1000,
            opts = function()
                vim.keymap.set("n", "<leader>f", Snacks.picker.files)
                vim.keymap.set("n", "<leader>g", Snacks.picker.grep)
                vim.keymap.set("n", "<leader>b", Snacks.picker.buffers)

                return {
                    notifier = {},
                    picker = {},
                }
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "bash",
                        "c",
                        "css",
                        "csv",
                        "html",
                        "java",
                        "javascript",
                        "json",
                        "lua",
                        "markdown",
                        "markdown_inline",
                        "python",
                        "regex",
                        "rust",
                        "scss",
                        "toml",
                        "vim",
                    },
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end,
        },
    },
    rocks = { enabled = false },
    install = { colorscheme = { "catppuccin-mocha" } },
    ui = {
        custom_keys = {
            ["<localleader>l"] = false,
            ["<localleader>i"] = false,
            ["<localleader>t"] = false,
        },
    },
})
