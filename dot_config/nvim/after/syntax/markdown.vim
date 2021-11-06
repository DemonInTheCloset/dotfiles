syntax include @tex syntax/tex.vim

syntax region markdownLatexInline start=/\v\$[^$]/ end=/\v\$/ contains=@tex
syntax region markdownLatex start=/\v\$\$/ end=/\v\$\$/ contains=@tex

highlight link markdownLatexInline SpecialComment
highlight link markdownLatex SpecialComment
