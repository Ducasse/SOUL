converting
transformTabledRules: aCollection withCallGraph: aCallGraph
	
	| uniqueRules newRules key values |
	newRules := OrderedCollection new.
	uniqueRules := Dictionary new.
	aCollection
		do:
			[:aTabledRule | 
			key := aTabledRule conclusion functor asString.
			values := uniqueRules
				at: key
				ifAbsent: [OrderedCollection new].
			values
				detect: [:x | x conclusion isSLGEquivalentTo: aTabledRule conclusion]
				ifNone: [values add: aTabledRule].
			uniqueRules at: key put: values].
	uniqueRules
		do:
			[:rules | rules do: [:aTabledRule | newRules add: aTabledRule slgTransformMain]].
	aCollection
		do:
			[:aTabledRule | 
			newRules
				addAll:
					(aTabledRule slgTransformWith: aCollection withCallGraph: aCallGraph)].
	^newRules