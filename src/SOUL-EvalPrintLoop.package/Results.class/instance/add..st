private-access
add: aCollectionOfBindings
	
	| coll |
	aCollectionOfBindings ~~ false
		ifTrue:
			[self success: true.
			aCollectionOfBindings
				do:
					[:aBinding | 
					| var |
					var := aBinding variable.
					var isHiddenVariable
						ifFalse:
							[coll := results
								at: var
								ifAbsentPut: [OrderedCollection new].
							coll add: aBinding value]]].
	self changed: #add: