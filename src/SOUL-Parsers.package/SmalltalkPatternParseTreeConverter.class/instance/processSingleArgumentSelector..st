private
processSingleArgumentSelector: anRBKeyword
	
	^anRBKeyword isPatternVariable
		ifTrue:
			[| var |
			var := RBPatternVariableNode identifierToken: anRBKeyword.
			var isList
				ifTrue: [self processSelectorVariable: anRBKeyword]
				ifFalse:
					[SoulFactory current makeList
						termSequence:
							(TermSequence
								terms:
									(OrderedCollection with: (self processSelectorVariable: anRBKeyword)))]]
		ifFalse: [anRBKeyword value]