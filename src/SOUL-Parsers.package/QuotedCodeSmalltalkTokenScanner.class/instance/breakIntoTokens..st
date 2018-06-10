public access
breakIntoTokens: textOrString
	"Answer a sequence of DifferSubstrings for aTextOrString, one substring per token.
	 This is for tokenized comparison of code."

	
	|  terms   |
	terms := OrderedCollection new: textOrString size // 4.
	self scan: (ReadStream on: (textOrString string)).
	[(tokenType = #xspace or:[tokenType = #doIt])
		ifFalse:
			[
			 terms
				addLast:
					(self
						makeTerm: tokenType asSymbol
						with: token asString asSymbol)].
		tokenType = #doIt]
		whileFalse:
			[self scanToken].
	^SoulFactory current makeList termSequence: (TermSequence terms: terms)