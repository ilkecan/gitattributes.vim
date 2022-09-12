if exists('b:current_syntax')
  finish
endif

" SYNTAX
" attribute
syntax match gitattributesAttrName '[A-Za-z0-9_.][-A-Za-z0-9_.]*'
  \ contained
  \ nextgroup=gitattributesAttrValue,
syntax match gitattributesAttrPrefix '[!-]'
  \ contained
  \ nextgroup=gitattributesAttrName,
syntax match gitattributesAttrValue '=\S\+'ms=s+1
  \ contained
syntax match gitattributesAttr '\s\zs[!-]\?[A-Za-z0-9_.][-A-Za-z0-9_.]*\%(=\S\+\)\?'
  \ contained
  \ nextgroup=gitattributesAttr
  \ transparent
  \ contains=
    \ gitattributesAttrName,
    \ gitattributesAttrPrefix,
    \ gitattributesAttrValue,

" pattern
syntax match gitattributesBrackets '[[\]]'
  \ contained
syntax match gitattributesDirSeparator '/'
  \ contained
syntax match gitattributesEscapedCharacter '\\.'
  \ contained
syntax match gitattributesPattern '^\s*\zs\%(\\.\|[^\\[:blank:]]\)\+'
  \ contained
  \ nextgroup=gitattributesAttr
  \ contains=
    \ gitattributesDirSeparator,
    \ gitattributesEscapedCharacter,
    \ gitattributesRange,
    \ gitattributesWildcard,
syntax match gitattributesRange '\[.*\]'
  \ contained
  \ contains=
    \ gitattributesBrackets,
syntax match gitattributesWildcard '[*?]'
  \ contained

" pattern attr1 attr2 ...
syntax match gitattributesPatternAttrLine '^.*$'
  \ transparent
  \ contains=
    \ gitattributesAttr,
    \ gitattributesPattern,

" macro
syntax match gitattributesMacroPrefix '^\s*\zs\[attr\]'
  \ contained
  \ nextgroup=gitattributesMacroAttrName

syntax match gitattributesMacroName '\[attr\]\zs.*'
  \ nextgroup=gitattributesAttr
  \ contains=
    \ gitattributesAttrName,

syntax match gitattributesMacroLine '^.*\[attr\].*$'
  \ transparent
  \ contains=
    \ gitattributesAttr,
    \ gitattributesMacroName,
    \ gitattributesMacroPrefix,

" comment
syn match	gitattributesComment	"^\s*#.*$"
  \ contains=
    \ gitattributesTodo,@Spell,
syn keyword	gitattributesTodo
  \ contained
  \ FIXME
  \ TODO
  \ XXX

" HIGHLIGHT
" attribute
highlight link gitattributesAttrName Identifier
highlight link gitattributesAttrPrefix SpecialChar
highlight link gitattributesAttrValue Constant

" pattern
highlight link gitattributesBrackets Delimiter
highlight link gitattributesDirSeparator Delimiter
highlight link gitattributesEscapedCharacter gitattributesPattern
highlight link gitattributesPattern Constant
highlight link gitattributesRange Identifier
highlight link gitattributesWildcard SpecialChar

" macro
highlight link gitattributesMacroPrefix Keyword

" comment
highlight link gitattributesComment Comment
highlight link gitattributesTodo Todo

let b:current_syntax = 'gitattributes'
