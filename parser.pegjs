// TODO: Probably relief the leading <?xml version='1.1'?> requirement
{
}

// 1. TODO: Omitted "- (Char* RestrictedChar Char*)"
document = prolog element Misc*
// 2. TODO: Omitted [\u10000-\u10FFFF]
Char = [\u0001-\uD7FF\uE000-\uFFFD]

// Char - '-', omitted [\u10000-\u10FFFF]
CharNoDash = [\u0001-\u002c\u002e-\uD7FF\uE000-\uFFFD]
// Char - '?', TODO: omitted [\u10000-\u10FFFF]
CharNoQuestion = [\u0001-\u003e\u0040-\uD7FF\uE000-\uFFFD]
// Char - '>', TODO: omitted [\u10000-\u10FFFF]
CharNoGT = [\u0001-\u003d\u003f-\uD7FF\uE000-\uFFFD]
// Char - ']'
CharNoRSB = [\u0001-\u005c\u005e-\uD7FF\uE000-\uFFFD]

// 3.
S = [\u0020\u0008\u000D\u000A]
// 4.
NameStartChar = [:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u00FF\u0370-\u037D\u037f\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD] // TODO: Omitted [#x10000-#xEFFFF]
// 4a.
NameChar = NameStartChar / [-\.0-9\u00B7\u0300-\u036F\u203F-\u2040]
// 5.
Name = $(NameStartChar NameChar*)
// 6.
Names = Name ([\u0020] Name)*
// 7.
Nmtoken = NameChar+
// 8.
Nmtokens = Nmtoken ([\u0020] Nmtoken)*
// 9.
EntityValue = '"' ([^%&"] / PEReference / Reference)* '"' / "'" ([^%$'] / PEReference / Reference)* "'"
// 10.
AttValue = '"' ([^<&"] / Reference)* '"' / "'" ([^<&'] / Reference)* "'"
// 11.
SystemLiteral = ('"' [^"]* '"') / ("'" [^']* "'")
// 12.
PubidCharNoSQuot = [\u0020\u000D\u000Aa-zA-Z0-9\-\(\)\+,\.\/:=\?;!\*#@\$_%]
PubidLiteral = '"' PubidChar* '"' / "'" PubidCharNoSQuot* "'"
// 13.
PubidChar = [\u0020\u000D\u000Aa-zA-Z0-9\-'\(\)\+,\.\/:=\?;!\*#@\$_%]
// 14. Translated: [^<&]* - ([^<&]* ']]>' [^<&]*) 
CharData = ([^<&] / ']' [^<&\]] / ']]' [^<&>])*
// 15. NOTE: Translated
Comment = '<!--' (CharNoDash / ('-' CharNoDash))* '-->'
// 16. NOTE: Translated (Char* - (Char* '?>' Char*)) as (CharNoQuestion / '?' CharNoGT)*
PI = '<?' PITarget (S (CharNoQuestion / '?' CharNoGT)*)? '?>'
// 17.
PITarget = Name // TODO: - (('X' / 'x') ('M' / 'm') ('L' / 'l))
// 18.
CDSect = CDStart CData CDEnd
// 19.
CDStart = '<![CDATA['
// 20. Translated: (Char* - (Char* ']]>' Char*)) TODO: Omitted [\u10000-\u10FFFF] 
CData = (CharNoRSB / ']' CharNoRSB / ']]' CharNoGT)*
// 21.
CDEnd = ']]>' 
// 22.
prolog = XMLDecl Misc* (doctypedecl Misc*)?
// 23.
XMLDecl = '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
// 24.
VersionInfo = S 'version' Eq ("'" VersionNum "'" / '"' VersionNum '"')
// 25.
Eq = S? '=' S?
// 26.
VersionNum = '1.1'
// 27.
Misc = Comment / PI / S
// 28.
doctypedecl = '<!DOCTYPE' S Name (S ExternalID)? S? ('[' intSubset ']' S?)? '>'
// 28a.
DeclSep = PEReference / S
// 28b.
intSubset = (markupdecl / DeclSep)*
// 29
markupdecl = elementdecl / AttlistDecl / EntityDecl / NotationDecl / PI / Comment

// 32.
SDDecl = S 'standalone' Eq (("'" ('yes' / 'no') "'") / ('"' ('yes' / 'no') '"'))

// 39.
element = EmptyElemTag / STag content ETag
// 40.
STag = '<' Name (S Attribute)* S? '>'
// 41.
Attribute = name:Name eq:Eq value:AttValue 
// 42.
ETag = '</' Name S? '>'
// 43.
content = CharData? ((element / Reference / CDSect / PI / Comment) CharData?)*
// 44.
EmptyElemTag = '<' name:Name attributes:(S Attribute)* S? '/>'
// 45.
elementdecl = '<!ELEMENT' S Name S contentspec S? '>'
// 46.
contentspec = 'EMPTY' / 'ANY' / Mixed / children
// 47.
children = (choice / seq) ('?' / '*' / '+')?
// 48.
cp = (Name / choice / seq) ('?' / '*' / '+')?
// 49.
choice = '(' S? cp (S? '|' S? cp)+ S? ')'
// 50.
seq = '(' S? cp (S? ',' S? cp)* S? ')'
// 51.
Mixed = '(' S? '#PCDATA' (S? '|' S? Name)* S? ')*' / '(' S? '#PCDATA' S? ')'
// 52.
AttlistDecl = '<!ATTLIST' S Name AttDef* S? '>'
// 53.
AttDef = S Name S AttType S DefaultDecl
// 54.
AttType = StringType / TokenizedType / EnumeratedType
// 55.
StringType = 'CDATA'
// 56.
TokenizedType = 'ID' / 'IDREF' / 'IDREFS' / 'ENTITY' / 'ENTITIES' / 'NMTOKEN' / 'NMTOKENS'
// 57.
EnumeratedType = NotationType / Enumeration
// 58.
NotationType = 'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')'
// 59.
Enumeration = '(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')'
// 60.
DefaultDecl = '#REQUIRED' / '#IMPLIED' / (('#FIXED' S)? AttValue)

// 66.
CharRef = '&#' [0-9]+ ';' / '&#x' [0-9a-fA-F]+ ';'
// 67.
Reference = EntityRef / CharRef
// 68.
EntityRef = '&' Name ';'
// 69.
PEReference = '%' Name ';'
// 70.
EntityDecl = GEDecl / PEDecl
// 71.
GEDecl = '<!ENTITY' S Name S EntityDef S? '>'
// 72.
PEDecl = '<!ENTITY' S '%' S Name S PEDef S? '>'
// 73.
EntityDef = EntityValue / (ExternalID NDataDecl?)
// 74.
PEDef = EntityValue / ExternalID

// 75.
ExternalID = 'SYSTEM' S SystemLiteral / 'PUBLIC' S PubidLiteral S SystemLiteral
// 76.
NDataDecl = S 'NDATA' S Name

// 80.
EncodingDecl = S 'encoding' Eq ('"' EncName '"' / "'" EncName "'")
// 81.
EncName = [A-Za-z] ([A-Za-z0-9._] / '-')*
// 82.
NotationDecl = '<!NOTATION' S Name S (ExternalID / PublicID) S? '>'
// 83.
PublicID = 'PUBLIC' S PubidLiteral