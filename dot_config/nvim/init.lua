-- Enable Filetype Plugin
vim.cmd("filetype plugin on")

local config_files = {
    "user/plugins",
    "user/settings",
    "user/cmp",
    "user/treesitter",
    "user/lsp-config",
    "user/statusline",
    "user/augroups",
    "user/telescope",
    -- 'error_file', -- test file to make sure errors are non fatal
}

-- Source configuration
for _, file in ipairs(config_files) do
    local ok, _ = pcall(require, file)
    if not ok then
        print("Error in config file: " .. file)
    end
end
