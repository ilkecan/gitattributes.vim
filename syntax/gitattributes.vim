if exists('b:current_syntax')
  finish
endif

" SYNTAX
" c.vim, for cCppString
syntax include syntax/c.vim

" attribute
syntax match gitattributesAttrName '[[:alnum:]_.][[:alnum:]_.-]*'
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
syntax region gitattributesGroup matchgroup=gitattributesBrackets start="\[" skip="\\\]" end="\]"
  \ oneline
  \ contained
  \ contains=
    \ gitattributesRange,
syntax match gitattributesPattern '^\s*\zs\S\+'
  \ transparent
  \ contained
  \ nextgroup=gitattributesAttr
  \ contains=
    \ gitattributesString,
    \ gitattributesString,
    \ gitattributesPath,
syntax match gitattributesPath '\%(\\.\|[^\\[:blank:]]\)\+'
  \ contained
  \ contains=
    \ gitattributesDirSeparator,
    \ gitattributesEscapedCharacter,
    \ gitattributesGroup,
    \ gitattributesWildcard,
syntax match gitattributesRange '\%(\d-\d\|\a-\a\)'
  \ contained
  \ contains=
    \ gitattributesRangeSeperator,
syntax match gitattributesRangeSeperator '-'
  \ contained
syntax match gitattributesString '".*[^\\]"'
  \ transparent
  \ contained
  \ contains=
    \ cCppString,
syntax match gitattributesWildcard '[*?]'
  \ contained

" pattern attr1 attr2 ...
syntax match gitattributesPatternAttrLine '^.*$'
  \ transparent
  \ contains=
    \ gitattributesAttr,
    \ gitattributesPattern,

" macro
syntax match gitattributesMacroLine '^\s*\[attr\].*$'
  \ transparent
  \ contains=
    \ gitattributesAttr,
    \ gitattributesMacroPrefix,
syntax match gitattributesMacroName '\[attr\]\zs\S\+'
  \ contained
  \ nextgroup=gitattributesAttr
  \ contains=
    \ gitattributesAttrName,
syntax match gitattributesMacroPrefix '\[attr\]\S\+'
  \ contained
  \ contains=
    \ gitattributesMacroName,

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
highlight link gitattributesEscapedCharacter SpecialChar
highlight link gitattributesGroup Character
highlight link gitattributesPath Constant
highlight link gitattributesRange Character
highlight link gitattributesRangeSeperator Delimiter
highlight link gitattributesWildcard SpecialChar

" macro
highlight link gitattributesMacroPrefix Keyword

" comment
highlight link gitattributesComment Comment
highlight link gitattributesTodo Todo

let b:current_syntax = 'gitattributes'
