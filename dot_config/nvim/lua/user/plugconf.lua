local colorizer_conf = {}
colorizer_conf["*"] = { names = false, RRGGBBAA = true }
require("colorizer").setup(colorizer_conf)

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.google_java_format,
	},
})
