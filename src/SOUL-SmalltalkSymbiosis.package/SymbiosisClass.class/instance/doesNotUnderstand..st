as yet unclassified
doesNotUnderstand: message
	| queryText arguments counter results resultVariables |
	counter := 1.
	queryText := 'if ?self'.
	arguments := OrderedCollection with: #self -> self.
	resultVariables := Dictionary new.
	message selector numArgs > 0
		ifTrue: [ 
			message selector keywords
				do: [ :keyword | 
					queryText := queryText , ' ' , keyword asString , ' ?x' , counter asString.
					counter := counter + 1 ].
			message arguments
				keysAndValuesDo: [ :idx :arg | 
					(arg isKindOf: UninitializedTemporary)
						ifTrue: [ resultVariables at: 'x' , idx asString put: arg ]
						ifFalse: [ arguments add: ('x' , idx asString) asSymbol -> arg ] ] ]
		ifFalse: [ queryText := queryText , ' ' , message selector keywords first asString ].
	queryText := queryText , ' = ?result'.
	results := (SoulFactory current evaluatorForLogicQuery
		eval: queryText
		in: SoulFactory transparentSymbiosisRepository
		withAssociations: arguments) allResults.
	results success
		ifTrue: [ 
			resultVariables
				keysAndValuesDo: [ :queryVar :uninitSTVar | uninitSTVar become: (results downedResultsForVariableNamed: queryVar) ] ].
	^ results success
		ifTrue: [ results downedResultsForVariableNamed: 'result' ]
		ifFalse: [ false ]