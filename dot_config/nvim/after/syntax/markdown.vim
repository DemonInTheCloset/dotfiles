syntax region markdownLatexInline start=/\v\$[^$]/ end=/\v\$/
highlight link markdownLatexInline String

syntax region markdownLatex start=/\v\$\$/ end=/\v\$\$/
highlight link markdownLatex String
