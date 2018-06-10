quotedCode
quotedCodeToList
	
	| previous |
	previous := self asNormalVariable.
	decorators
		reverseDo:
			[:each | 
			previous := SoulFactory current makeCompound
				functor: each
				termSequence:
					(SoulFactory current makeTermSequence terms: (OrderedCollection with: previous))].
	^previous