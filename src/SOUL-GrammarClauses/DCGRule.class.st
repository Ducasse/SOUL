Class {
	#name : #DCGRule,
	#superclass : #Rule,
	#category : 'SOUL-GrammarClauses'
}

{ #category : #initialize }
DCGRule >> condition: aCondition conclusion: aConclusion [
	
	containsCut := aCondition containsCut.
	condition := aCondition.
	conclusion := aConclusion.
	self convertToRule
]

{ #category : #private }
DCGRule >> convertConclusion [
	
	conclusion := conclusion asDCGConclusionWithSize: condition terms size + 1
]

{ #category : #private }
DCGRule >> convertCondition [
	
	| counter newTerms |
	counter := 1.
	newTerms := OrderedCollection new.
	condition terms
		do:
			[:aTerm | 
			newTerms add: (aTerm asDCGConditionFor: counter).
			counter := counter + 1].
	condition terms: newTerms
]

{ #category : #private }
DCGRule >> convertToRule [
	"Convert the DCG spec in this rule to a logic rule that is able to execute the parsing process:
		s(a,b) --> np(a),vp(b)   ==>>  s(a,b,L1,L3) if np(a,L1,L2),vp(b,L2,L3)"

	
	self convertConclusion.
	self convertCondition
]

{ #category : #printing }
DCGRule >> prettyPrintConclusionOn: aStream [
	
	| subterms |
	conclusion functor prettyPrintAsFunctorOn: aStream scope: #asClause.
	subterms := conclusion termSequence terms.
	subterms size > 2
		ifTrue:
			[aStream write: '('.
			(1 to: subterms size - 2)
				do: [:i | (subterms at: i) prettyPrintOn: aStream scope: #asTerm]
				separatedBy: [aStream write: ','].
			aStream write: ')']
]

{ #category : #printing }
DCGRule >> prettyPrintCondition: aCondition on: aStream [
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
]

{ #category : #printing }
DCGRule >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractClause"

	
	self prettyPrintCommentOn: aStream.
	self prettyPrintConclusionOn: aStream.
	aStream withAttributes:(Array with: TextEmphasis bold with:(TextColor red)) do:[
	aStream write: ' --> '].
	condition terms
		do: [:aCondition | self prettyPrintCondition: aCondition on: aStream]
		separatedBy: [aStream write: ',']
]

{ #category : #printing }
DCGRule >> printConclusionOn: aStream [
	
	| subterms |
	conclusion functor printOn: aStream.
	subterms := conclusion termSequence terms.
	subterms size > 2
		ifTrue:
			[aStream write: '('.
			(1 to: subterms size - 2)
				do: [:i | (subterms at: i) printOn: aStream]
				separatedBy: [aStream write: ','].
			aStream write: ')']
]

{ #category : #printing }
DCGRule >> printCondition: aCondition on: aStream [
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
]

{ #category : #printing }
DCGRule >> printOn: aStream [
	
	self printCommentOn: aStream.
	self printConclusionOn: aStream.
	aStream write: ' --> '.
	condition terms
		do: [:aCondition | self printCondition: aCondition on: aStream]
		separatedBy: [aStream write: ',']
]
