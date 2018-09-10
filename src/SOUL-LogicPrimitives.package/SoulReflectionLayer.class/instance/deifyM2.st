terms
deifyM2

deify(?var,?term) if 
	getEnv(?env,?),envLookup(?term,?termPointer),envLookup(?var,?varPointer),[| theIndex theTerm fixer |
fixer := FixVisitor new.
?termPointer term isUppedObject
	ifTrue: [theTerm := ?termPointer term soulDownIn: nil startAt: nil]
	ifFalse: [theTerm := ?termPointer term].
theTerm accept: fixer.
theIndex := ?env startUnify: fixer maxIndex + 1.
theTerm
	unifyWith: ?varPointer term
	inEnv: ?env
	myIndex: theIndex
	hisIndex: ?varPointer envIndex
	inSource: false]