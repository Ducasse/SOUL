slgtesting
isVariantOf: aTermSequence
	"we assume that both sequences are already SLGEquivalent"

	
	| myTerms otherTerms otherTerm dict |
	myTerms := self terms.
	otherTerms := aTermSequence terms.
	dict := Dictionary new.
	myTerms
		doWithIndex:
			[:term :index | 
			otherTerm := otherTerms at: index.
			term isVariable
				ifTrue:
					[dict
						at: term name
						ifAbsent:
							[dict
								at: term name
								put: otherTerm name].
					dict
						at: term name
						ifPresent: [:name | name = otherTerm name ifFalse: [^false]]]].
	^true