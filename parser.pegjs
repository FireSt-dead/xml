{
// XML 1.0: https://www.w3.org/TR/xml/
// Parser types
}

/* [1]  */ document = prolog element Misc*
/* [2]  */ Char = [\u0009] / [\u000A] / [\u000D] / [\u0020-\uD7FF] / [\uE000-\uFFFD] // TODO: [#x10000-#x10FFFF]
/* [3]  */ S = $[\u0020\u0009\u000D\u000A]+

EmptyElemTag = "<" Name (S Attribute)* S? "/>"

/* [4]  */ NameStartChar = ":" / [A-Z] / "_" / [a-z] /* TODO: Missing character ranges. */
/* [4a] */ NameChar = NameStartChar / "-" / "." / [0-9] /* TODO: Missing character ranges */
/* [5]  */ Name = $(NameStartChar (NameChar)*)

/* [9]  */ AttValue = '"' $([^<&"] / Reference)* '"' / "'" $([^<&'] / Reference)* "'"

/* [11] */ SystemLiteral = $(('"' [^"]* '"') / ("'" [^']* "'"))
/* [12] */ PubidLiteral = '"' $PubidChar* '"' / "'" $(PubidChar /* TODO: - "'" */)* "'"
/* [13] */ PubidChar = [\u0020] / [\u000D] / [\u000A] / [a-zA-Z0-9] / [-'()+,./:=?;!*#@$_%]

NonDashChar = Char // TODO: Char - '-'
/* [15] */ Comment = '<!--' (NonDashChar / ('-' NonDashChar))* '-->'

/* [16] */ PI = '<?' PITarget (S (Char* /* TODO: - (Char* '?>' Char*)*/) )? '?>'
/* [17] */ PITarget = Name /* TODO: - (('X' | 'x') ('M' | 'm') ('L' | 'l')) */

/* [22] */ prolog = XMLDecl? Misc* (doctypedecl Misc*)?
/* [23] */ XMLDecl = "<?xml" VersionInfo EncodingDecl? SDDecl? S? "?>"
/* [24] */ VersionInfo = S "version" Eq ("'" VersionNum "'" / '"' VersionNum '"')
/* [25] */ Eq = S? "=" S?
/* [26] */ VersionNum = $("1." [0-9]+)
/* [27] */ Misc = Comment / PI / S

/* [28] */ doctypedecl = '<!DOCTYPE' S Name (S ExternalID)? S? ('[' /* TODO: intSubset */ ']' S?)? '>'

/* [32] */ SDDecl = S 'standalone' Eq (("'" ('yes' / 'no') "'") / ('"' ('yes' / 'no') '"'))

/* [39] */ element = EmptyElemTag // TODO: / STag content ETag

/* [41] */ Attribute = Name Eq AttValue

/* [66] */ CharRef = '&#' [0-9]+ ';' / '&#x' [0-9a-fA-F]+ ';'
/* [67] */ Reference = EntitiyRef / CharRef
/* [68] */ EntitiyRef = '&' Name ';'
/* [69] */ PEReference = '%' Name ';' 

/* [75] */ ExternalID = 'SYSTEM' S SystemLiteral / 'PUBLIC' S PubidLiteral S SystemLiteral

/* [80] */ EncodingDecl = S 'encoding' Eq ('"' EncName '"' / "'" EncName "'")
/* [81] */ EncName = $([A-Za-z] ([A-Za-z0-9._] / '-')*)