private
parseVariables
	
	| dict visitor |
	variables := OrderedCollection new.
	dict := Dictionary new.
	visitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			dict
				at: var name
				ifAbsentPut:
					[variables addLast: var.
					var]].
	content do: [:each | each accept: visitor].
	variables addFirst: nil.
	variables addFirst: nil.
	variables := variables asArray