*SOUL-Kernel
listTermFrom: start to: stop
	
	| coll |
	coll := OrderedCollection new.
	start
		to: stop
		do: [:i | coll add: (self cachedSoulChildren at: i)].
	^SoulFactory current makeList new
		addChildrenInitial: (OrderedCollection with: (TermSequence terms: coll))