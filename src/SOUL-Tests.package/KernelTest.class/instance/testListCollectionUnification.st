evaluator
testListCollectionUnification
	"self run:#testListCollectionUnification"

	
	self processQuery:
			' if equals(<a,b,c>,[OrderedCollection with: #a with: #b with: #c])'
		description: 'Do lists correctly unify with sequenceable collections?'.
	self processQuery:
			' if equals([OrderedCollection with: #a with: #b with: #c],<a,b,c>)'
		description: 'Do lists correctly unify with sequenceable collections?'.
	self processQuery: ' if equals(<>,[OrderedCollection new])' description:
			'Do empty lists correctly unify with empty sequenceable collections?'.
	self processQuery: ' if equals([OrderedCollection new],<>)' description:
			'Do empty lists correctly unify with empty sequenceable collections?'.
	self processQuery:
			' if equals([OrderedCollection
	with: #a
	with: (OrderedCollection with: #b)
	with: #c],<a,<b>,c>)' description: 'Do nested list unify?'.
	self processQuery:
			' if fails(equals([OrderedCollection with: #a with: #b],<a,b,c>))'
		description: 'Does unification fail when elements do not correspond?'.
	self processQuery:
			' if fails(equals([OrderedCollection with: #foo with: #bar],<a,b>))'
		description: 'Does unification fail when elements do not correspond?'