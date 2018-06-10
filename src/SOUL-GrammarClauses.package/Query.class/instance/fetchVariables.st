private
fetchVariables
	
	| dict variableVisitor |
	dict := Dictionary new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			dict
				at: var name
				ifAbsentPut: [var]].
	condition accept: variableVisitor.
	^dict asOrderedCollection