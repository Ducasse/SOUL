storage-conversion
copyFromLayerWithOldStorageSystem: oldLayer
	"This method can be used to convert layers that are still stored using one
	of the old storage systems or that were edited directly using the class
	browser rather than the clause browser. It is best to make a new layer first,
	and then send it this message using the old layer as the argument."

	
	| clauses |
	oldLayer organization categories
		do:
			[:eachCategory | 
			(oldLayer organization listAtCategoryNamed: eachCategory)
				do:
					[:selector | 
					clauses := oldLayer new perform: selector.
					self
						assertClauses: clauses
						inProtocol: eachCategory
						ifAlreadyClassified: [:predicate :oldProtocol :newProtocol | false]]]