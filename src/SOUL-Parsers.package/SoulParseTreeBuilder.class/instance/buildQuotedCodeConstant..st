building SmalltalkTerm/QuotedCode
buildQuotedCodeConstant: aString
	
	^SoulFactory current makeQuotedCodeConstant name: aString asSymbol