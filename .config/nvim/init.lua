vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_netrw = 1
vim.g.loaded_nvim_net_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
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

vim.keymap.set("n", "<leader>t", "<cmd>terminal<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>terminal lazygit<CR>")

function Change_CWD(path)
    vim.api.nvim_exec2("wa!", {})
    vim.api.nvim_exec2("%bd!", {})
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.api.nvim_exec2("cd " .. path, {})
    vim.api.nvim_exec2("e .", {})
end

vim.keymap.set("n", "<leader>mc", function() Change_CWD("~/.config/nvim") end)
vim.keymap.set("n", "<leader>mp", function() Change_CWD("~") end)

function Center_Cursor(insert_mode)
    vim.diagnostic.config({ virtual_lines = false })

    local line = vim.api.nvim_win_get_cursor(0)[1]

    if vim.b.last_line == nil then
        vim.b.last_line = line
    end

    if line ~= vim.b.last_line then
        local column = vim.fn.getcurpos()[3]

        vim.api.nvim_exec2("normal! zz", {})
        vim.b.last_line = line

        if insert_mode then
            vim.fn.cursor({ line, column })
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

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)


vim.api.nvim_create_autocmd("PackChanged", { callback = function(e)
    if e.data.spec.name == 'nvim-treesitter' and e.data.kind == 'update' then
        vim.cmd("TSUpdate")
    end
end })

vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1.10.1",
    },
    "https://github.com/catppuccin/nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/folke/noice.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/stevearc/oil.nvim",
})

require("blink.cmp").setup({
    signature = { enabled = true },
})

vim.cmd.colorscheme("catppuccin-mocha")

require("noice").setup({
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = false },
    },
})
require("snacks").setup({
    bigfile = {},
    notifier = {},
    picker = {},
})

vim.keymap.set("n", "<leader>f", Snacks.picker.files)
vim.keymap.set("n", "<leader>g", Snacks.picker.grep)
vim.keymap.set("n", "<leader>b", Snacks.picker.buffers)

vim.lsp.config("luals", {
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
vim.lsp.enable("jedi_language_server")
vim.lsp.enable("luals")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ty")

require("lualine").setup({
    options = { theme = "catppuccin-mocha" },
})

require("nvim-treesitter.config").setup({
    ensure_installed = {
        "bash",
        "c",
        "css",
        "csv",
        "html",
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

require("oil").setup({
    delete_to_trash = true,
    keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-r>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["~"] = { "actions.cd", mode = "n" },
    },
    use_default_keymaps = false,
    view_options = { show_hidden = true },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>");
