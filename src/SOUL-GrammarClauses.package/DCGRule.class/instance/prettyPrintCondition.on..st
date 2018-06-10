printing
prettyPrintCondition: aCondition on: aStream
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
			[| temp |
			temp := aStream emphasis.
			aStream
				emphasis:
					(Array
						with: #color -> ColorValue purple
						with: #bold).
			aStream write: '<'.
			aStream emphasis: temp.
			terminals := OrderedCollection new.
			aCondition termSequence terms last
				listDo: [:aTerminal | terminals add: aTerminal].
			terminals
				do:
					[:aTerminal | 
					(aTerminal isKindOf: Variable)
						ifFalse: [aTerminal prettyPrintOn: aStream scope: #asTerm]]
				separatedBy: [aStream write: ','].
			aStream
				emphasis:
					(Array
						with: #color -> ColorValue purple
						with: #bold).
			aStream write: '>'.
			aStream emphasis: temp]
		ifFalse:
			[(aCondition isKindOf: CompoundTerm)
				ifTrue:
					[aCondition functor prettyPrintAsFunctorOn: aStream scope: #asClause.
					subterms := aCondition termSequence terms.
					subterms size > 2
						ifTrue:
							[aStream write: '('.
							(1 to: subterms size - 2)
								do: [:i | (subterms at: i) prettyPrintOn: aStream scope: #asClause]
								separatedBy: [aStream write: ','].
							aStream write: ')']]
				ifFalse: [aCondition printOn: aStream]]