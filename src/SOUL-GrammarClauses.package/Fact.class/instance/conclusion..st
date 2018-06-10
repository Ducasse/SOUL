initialize
conclusion: aTerm
	
	super
		condition:
			(SoulFactory current makeTermSequence
				terms: OrderedCollection new
				containsCut: false)
		conclusion: aTerm