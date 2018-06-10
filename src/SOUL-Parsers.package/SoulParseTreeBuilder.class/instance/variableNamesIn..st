SLG
variableNamesIn: aTerm
	
	| dict variableVisitor |
	dict := Dictionary new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			var isHiddenVariable
				ifFalse:
					[dict
						at: var name asSymbol
						ifAbsentPut: [var name asSymbol]]].
	aTerm accept: variableVisitor.
	^dict values asSet