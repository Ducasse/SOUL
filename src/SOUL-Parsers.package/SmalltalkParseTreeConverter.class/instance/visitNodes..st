visiting
visitNodes: aNodeCollection
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aNodeCollection collect: [:node | self visitNode: node]))