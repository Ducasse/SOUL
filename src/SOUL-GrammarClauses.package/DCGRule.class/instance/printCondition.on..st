printing
printCondition: aCondition on: aStream
	"DISCLAIMER: enjoy this wonderful method full of violations of the law of demeter and explicit type checks"

	"and is disallowed in the body of dcg rules for 'normal' users ... so it can only originate from the dcg translation of SymbiosisTerms"

	
	| terminals subterms |
	((aCondition isKindOf: CompoundTerm)
		and: [aCondition functor name == #and])
		ifTrue:
			[(aCondition termSequence terms at: 1) printOn: aStream.
			^self].
	((aCondition isKindOf: CompoundTerm)
		and: [aCondition functor name == #equals])
		ifTrue:
			[aStream write: '<'.
			terminals := OrderedCollection new.
			aCondition termSequence terms last
				listDo: [:aTerminal | terminals add: aTerminal].
			terminals
				do:
					[:aTerminal | (aTerminal isKindOf: Variable) ifFalse: [aTerminal printOn: aStream]]
				separatedBy: [aStream write: ','].
			aStream write: '>']
		ifFalse:
			[(aCondition isKindOf: CompoundTerm)
				ifTrue:
					[aCondition functor printOn: aStream.
					subterms := aCondition termSequence terms.
					subterms size > 2
						ifTrue:
							[aStream write: '('.
							(1 to: subterms size - 2)
								do: [:i | (subterms at: i) printOn: aStream]
								separatedBy: [aStream write: ','].
							aStream write: ')']]
				ifFalse: [aCondition printOn: aStream]]