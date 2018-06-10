building SmalltalkTerm/QuotedCode
buildQuotedCodeTerm: source
	
	^SoulFactory current makeQuotedCodeTerm
		source:
			(source
				copyFrom: 2
				to: source size - 1)