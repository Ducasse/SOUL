building SmalltalkTerm/QuotedCode
buildSmalltalkTerm: source
	
	^SoulFactory current makeSmalltalkTerm
		source:
			(source
				copyFrom: 2
				to: source size - 1)