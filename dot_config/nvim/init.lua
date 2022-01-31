-- Enable Filetype Plugin
vim.cmd("filetype plugin on")
vim.g.mapleader = " "

-- Continue reading configuration even if it contains an error
local function source_config(file)
    local ok, _ = pcall(require, file)
    if not ok then
        print("Error in config file: " .. file)
    end
end

source_config("user/plugins")
source_config("user/settings")
source_config("user/cmp")
source_config("user/treesitter")
source_config("user/lsp-config")
source_config("user/statusline")
source_config("user/augroups")
source_config("user/telescope")
source_config("user/plugconf")
source_config("user/maps")
