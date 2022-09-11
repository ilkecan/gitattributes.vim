if exists('b:current_syntax')
  finish
endif

" SYNTAX
" attribute
syntax match gitattributesAttrPrefix '[!-]'
  \ contained
  \ nextgroup=gitattributesAttrName,
syntax match gitattributesAttrName '[A-Za-z0-9_.][-A-Za-z0-9_.]*'
  \ contained
  \ nextgroup=gitattributesAttrValue,
syntax match gitattributesAttrValue '=\S\+'ms=s+1
  \ contained
syntax match gitattributesAttr '\s\zs[!-]\?[A-Za-z0-9_.][-A-Za-z0-9_.]\+\%(=\S\+\)\?'
  \ contained
  \ nextgroup=gitattributesAttr
  \ transparent
  \ contains=
    \ gitattributesAttrPrefix,
    \ gitattributesAttrName,
    \ gitattributesAttrValue,

" pattern
syntax match gitattributesDirSeparator '/'
  \ contained
syntax match gitattributesEscapedCharacter '\\.'
  \ contained
syntax match gitattributesBrackets '[[\]]'
  \ contained
syntax match gitattributesRange '\[.*\]'
  \ contained
  \ contains=gitattributesBrackets
syntax match gitattributesWildcard '[*?]'
  \ contained
syntax match gitattributesPattern '^\s*\zs\%(\\.\|[^\\[:blank:]]\)\+'
  \ contained
  \ nextgroup=gitattributesAttr
  \ contains=
    \ gitattributesDirSeparator,
    \ gitattributesEscapedCharacter,
    \ gitattributesRange,
    \ gitattributesWildcard,

" pattern attr1 attr2 ...
syntax match gitattributesPatternAttrLine '^.*$'
  \ transparent
  \ contains=
    \ gitattributesPattern,
    \ gitattributesAttr,

" macro
syntax match gitattributesMacroPrefix '^\s*\zs\[attr\]'
  \ contained
  \ nextgroup=gitattributesMacroAttrName

syntax match gitattributesMacroName '\[attr\]\zs.*'
  \ nextgroup=gitattributesAttr
  \ contains=gitattributesAttrName

syntax match gitattributesMacroLine '^.*\[attr\].*$'
  \ transparent
  \ contains=
    \ gitattributesMacroPrefix,
    \ gitattributesMacroName,
    \ gitattributesAttr,

syn keyword	gitattributesTodo
  \ contained
  \ FIXME
  \ TODO
  \ XXX
syn match	gitattributesComment	"^\s*#.*$"
  \ contains=gitattributesTodo,@Spell

" HIGHLIGHT
" macro
highlight link gitattributesMacroPrefix Keyword

" attribute
highlight link gitattributesAttrPrefix SpecialChar
highlight link gitattributesAttrName Identifier
highlight link gitattributesAttrValue Constant

" pattern
highlight link gitattributesBrackets Delimiter
highlight link gitattributesDirSeparator Delimiter
highlight link gitattributesEscapedCharacter gitattributesPattern
highlight link gitattributesRange Identifier
highlight link gitattributesWildcard SpecialChar
highlight link gitattributesPattern Constant

" comment
highlight link gitattributesComment Comment
highlight link gitattributesTodo Todo

let b:current_syntax = 'gitattributes'
