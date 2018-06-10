unification
unifyWithCompoundTerm: compound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with an object if my result of evaluation unifies with this  object"

	
	| object |
	object := (self evaluateIn: anEnv startAt: myIndex) soulUp.
	object == self
		ifTrue: [^false]
		ifFalse:
			[^object unifyWithCompoundTerm: compound inEnv: anEnv myIndex: myIndex
				hisIndex: hisIndex inSource: inSource]