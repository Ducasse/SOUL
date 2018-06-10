accessing-all
layerContainingClause: clause ifNone: noneBlock
	
	| coll |
	coll := OrderedCollection with: self.
	coll addAll: self allSubclasses.
	^coll
		detect: [:layer | layer containsClause: clause]
		ifNone: noneBlock