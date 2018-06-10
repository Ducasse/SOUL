unification
unifyWithTermSequence: other inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"transfered"

	
	collection size = other terms size ifFalse: [^false].
	collection
		with: other terms
		do:
			[:myTerm :otherTerm | 
			(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource) ifFalse: [^false]].
	^true