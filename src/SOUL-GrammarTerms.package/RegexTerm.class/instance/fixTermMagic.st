converting
fixTermMagic
	"in the hope of making our regexterm automagically work with the rest we are correcting our functor and termsequence,
	as SOUL will automagically run the correct query, generate a rainbow and some unicorns. If not all hell breaks lose
	and I will be a sad bunny"

	
	| collection startState endState path |
	collection := OrderedCollection with: (self getResultVariable).
	startState := self getStartWorld.
	endState := self getEndWorld.
	path := self getPathVariable.
	self prepareForModifyingTermsequence.
	
	collection add: startState.
	collection add: endState.
	collection add: path.
	termsequence := TermSequence terms: collection.
	self isExistential
		ifTrue:
			[functor := MessageFunctor
				name: 'somepath' , self identifier asString , ':endWorld:path:']
		ifFalse:
			[self isUniversal
				ifTrue:
					[functor := MessageFunctor
						name: 'allpaths' , self identifier asString , ':endWorld:']
				ifFalse:
					[self error:
							'regexterm without a universal (a) or existentional (e) quantifier']]