building SOUL
buildPair: aTermSequence cdr: aTerm
	"take a look at this... we should avoid unwrapping of the collection"

	
	^SoulFactory current makePair new
		addChildrenInitial:
			((OrderedCollection new)
				add: aTermSequence;
				add: aTerm;
				yourself)