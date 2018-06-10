slgtesting
isSLGEquivalentToTermSequence: aTermSequence
	
	| myTerms otherTerms otherTerm |
	myTerms := self terms.
	otherTerms := aTermSequence terms.
	myTerms size = otherTerms size ifFalse: [^false].
	myTerms
		doWithIndex:
			[:term :index | 
			otherTerm := otherTerms at: index.
			(term isSLGEquivalentTo: otherTerm) ifFalse: [^false]].	"even when all the individual terms match we still need to check cases like this:
	path(?X,?Y) vs path(?X,?X). The first one gives every path, the latter should return cycles"

	^(aTermSequence isVariantOf: self) and: [self isVariantOf: aTermSequence]