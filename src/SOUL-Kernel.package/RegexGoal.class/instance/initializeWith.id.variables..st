initialize-release
initializeWith: aCollection id: anInteger variables: varCollection
	
	termsequence := TermSequence terms: aCollection.
	transitionsTo := OrderedCollection new.
	goalId := anInteger.
	variables := varCollection