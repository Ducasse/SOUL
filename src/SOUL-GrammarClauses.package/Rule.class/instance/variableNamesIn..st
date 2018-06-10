private
variableNamesIn: aTerm
	
	| variables variableVisitor |
	variables := OrderedCollection new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			var isHiddenVariable
				ifFalse:
					[(variables includes: (var name asSymbol))
						ifFalse:[variables add: (var name asSymbol)]
						]].
	aTerm accept: variableVisitor.
	^variables