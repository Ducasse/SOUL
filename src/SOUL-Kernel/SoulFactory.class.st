Class {
	#name : #SoulFactory,
	#superclass : #Object,
	#classVars : [
		'CallIdCounter',
		'CallsPerCID',
		'CallsPerPredicate',
		'Current',
		'DependentNegatedOn',
		'DependentOn',
		'NameCounter',
		'Repositories',
		'RepositoriesDependents',
		'SLGCallStack',
		'WaitList'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'SLG - auxiliary' }
SoulFactory class >> addCallToStack: anSLGCall [
	"returns the dfn (depth first number)"

	
	SLGCallStack add: anSLGCall.
	^SLGCallStack size
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> addDependentCall: aCallTerm dependentOf: aWaitingNode [
	
	| alreadyDependent |
	alreadyDependent := DependentOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new].
	alreadyDependent add: aWaitingNode.
	DependentOn at: aCallTerm put: alreadyDependent
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> addNegatedDependentCall: aCallTerm dependentOf: aWaitingNode [
	
	| alreadyDependent |
	alreadyDependent := DependentNegatedOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new].
	alreadyDependent add: aWaitingNode.
	DependentNegatedOn at: aCallTerm put: alreadyDependent
]

{ #category : #private }
SoulFactory class >> addToWaitList: item [
	
	WaitList add: item
]

{ #category : #SLG }
SoulFactory class >> answer: aHead forCID: anInteger using: delayed [
	
	| call positiveDelayed negativeDelayed |
	positiveDelayed := delayed at: 1.
	negativeDelayed := delayed at: 2.
	call := CallsPerCID at: anInteger.
	(call includesAnswer: aHead using: delayed)
		ifFalse:
			[call addAnswer: aHead with: delayed.
			positiveDelayed
				do: [:aTerm | self addDependentCall: aTerm dependentOf: call].
			negativeDelayed
				do: [:aTerm | self addNegatedDependentCall: aTerm dependentOf: call].
			call evaluateWaitingNodesWithAnswer: aHead using: delayed]
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> callForCallTerm: aCallTerm [
	
	| callsForPredicate theCall |
	callsForPredicate := CallsPerPredicate
		at: aCallTerm predicate , aCallTerm multiplicity asString
		ifAbsentPut: [OrderedCollection new].
	theCall := callsForPredicate
		detect: [:aCall | aCall isSLGEquivalentTo: aCallTerm]
		ifNone: [self newSLGCallFor: aCallTerm inCollection: callsForPredicate].
	^theCall
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> completeCallTerm: aCallTerm [
	
	| poppedTerms copiedTerms positive negative justBelow |
	aCallTerm isCompletelyEvaluated
		ifTrue:
			[poppedTerms := self popUntilCallTerm: aCallTerm.
			poppedTerms asSet
				do:
					[:aTerm | 
					aTerm comp: true.
					self simplifyDependencyCallsFor: aTerm.
					aTerm removeWaitingNodes.
					aTerm evaluateNegativeWaitingNodes: false deleteNodes: true].
			^self].
	aCallTerm dependsOnCallDeepBelow
		ifTrue:
			[copiedTerms := self copyUntilCallTerm: aCallTerm.
			copiedTerms
				do:
					[:aTerm | 
					aTerm nlinkToMax.	"return undefined to negative waiting nodes"

					aTerm evaluateNegativeWaitingNodes: true deleteNodes: false].
			positive := Float infinity.
			negative := Float infinity.
			copiedTerms reverse
				do:
					[:aTerm | 
					aTerm plink == Float infinity
						ifFalse: [positive := positive min: aTerm plink].
					aTerm nlink == Float infinity
						ifFalse: [negative := negative min: aTerm nlink].
					aTerm plink: positive.
					aTerm nlink: negative.
					self completeCallTerm: aTerm].
			^self].
	justBelow := self justBelowTerm: aCallTerm.
	justBelow setMinPLink: aCallTerm plink.
	justBelow setMinNLink: aCallTerm nlink.
	^self
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> copyUntilCallTerm: aCallTerm [
	
	| result index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	result := SLGCallStack
		copyFrom: index
		to: SLGCallStack size.
	^result
]

{ #category : #accessing }
SoulFactory class >> current [
	
	^Current
]

{ #category : #'*SOUL-Kernel' }
SoulFactory class >> evaluator: aString [
	
	^Soul at: aString
]

{ #category : #'*SOUL-Kernel' }
SoulFactory class >> evaluators [
	
	^SoulEvaluator withAllSubclasses collect: [:e | e name]
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> getDependentCalls: aCallTerm [
	
	^DependentOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new]
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> getDependentNegatedCalls: aCallTerm [
	
	^DependentNegatedOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new]
]

{ #category : #'initialize-release' }
SoulFactory class >> initialize [
	
	WaitList := OrderedCollection new.
	NameCounter := 0.
	Repositories := Dictionary new.
	RepositoriesDependents := Set new.
	self resetSLGTables
]

{ #category : #'initialize-release' }
SoulFactory class >> initialize: aFactory [
	
	Current := aFactory
]

{ #category : #installing }
SoulFactory class >> install [
	
	SoulFactory current class = self ifFalse: [self initialize: self new]
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> justBelowTerm: aCallTerm [
	
	| index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	^SLGCallStack at: index - 1
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> newSLGCallFor: aLogicTerm inCollection: aCollection [
	
	| theCall |
	theCall := SLGCall
		call: aLogicTerm
		cid: self uniqueCallId.
	aCollection add: theCall.
	CallsPerCID
		at: theCall cid
		put: theCall.
	^theCall
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> popUntilCallTerm: aCallTerm [
	
	| result index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	result := SLGCallStack removeLast: SLGCallStack size - index + 1.
	^result
]

{ #category : #private }
SoulFactory class >> processWaitList [
	
	WaitList do: [:block | block value].
	WaitList := OrderedCollection new
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> resetSLGTables [
	
	CallsPerCID := Dictionary new.
	CallsPerPredicate := Dictionary new.
	CallIdCounter := 0.
	SLGCallStack := OrderedCollection new.
	DependentOn := Dictionary new.
	DependentNegatedOn := Dictionary new
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> simplifyDependencyCallsFor: aCallTerm [
	
	| positiveDependents negativeDependents |
	positiveDependents := self getDependentCalls: aCallTerm.
	negativeDependents := self getDependentNegatedCalls: aCallTerm.
	positiveDependents
		do: [:aCall | aCall simplifyAnswers: aCallTerm isNegated: false].
	negativeDependents
		do: [:aCall | aCall simplifyAnswers: aCallTerm isNegated: true]
]

{ #category : #SLG }
SoulFactory class >> slg: aCallTerm [
	
	| theCall |
	theCall := self callForCallTerm: aCallTerm.
	theCall comp
		ifFalse:
			[theCall evaluate.
			self completeCallTerm: theCall].
	^theCall answersShowMuffled: true
]

{ #category : #SLG }
SoulFactory class >> slgcall: aCallTerm forCID: anInteger variables: vars delay: delay continuation: cont [
	
	| call otherCall |
	call := self callForCallTerm: aCallTerm.
	otherCall := CallsPerCID at: anInteger.
	call addWaitingId: anInteger variables: vars delay: delay continuation: cont.
	call isNew
		ifTrue:
			[call evaluate.
			self completeCallTerm: call.
			otherCall comp
				ifFalse:
					[otherCall setMinPLink: call plink.
					otherCall setMinNLink: call nlink]]
		ifFalse:
			[otherCall setMinPLink: call plink.
			otherCall setMinNLink: call nlink.
			call evaluateAnswersWith: cont id: anInteger vars: vars delay: delay]
]

{ #category : #SLG }
SoulFactory class >> slgnot: aCallTerm forCID: anInteger variables: vars delay: delay continuation: cont [
	
	| call otherCall |
	call := self callForCallTerm: aCallTerm.
	otherCall := CallsPerCID at: anInteger.
	call isNew
		ifTrue:
			[call addNegativeWaitingId: anInteger variables: vars delay: delay
				continuation: cont.
			call evaluate.
			self completeCallTerm: call.
			call comp
				ifFalse:
					[call hasMaxNLink
						ifFalse: [otherCall setMinNLink: (call nlink min: call plink)]
						ifTrue: [otherCall setMinNLink: call plink]]]
		ifFalse:
			[call answers isEmpty
				ifTrue:
					["call does not have an answer without delayed vars"

					call comp
						ifFalse:
							[call addNegativeWaitingId: anInteger variables: vars delay: delay
								continuation: cont.	"call evaluateAnswersWith: cont id: anInteger vars: vars delay: delay."

							call hasMaxNLink
								ifFalse: [otherCall setMinNLink: (call nlink min: call plink)]
								ifTrue: [otherCall setMinNLink: call plink]]
						ifTrue:
							[call
								evaluateNegativeWaitingNode:
									(WaitingNode
										callId: anInteger
										variables: vars
										delayedPrimitives: (delay at: 1) copy
										delayedNegatedPrimitives: (delay at: 2) copy
										continuation: cont)]]]
]

{ #category : #'SLG - auxiliary' }
SoulFactory class >> uniqueCallId [
	
	CallIdCounter := CallIdCounter + 1.
	^CallIdCounter
]

{ #category : #accessing }
SoulFactory class >> uniqueCounter [
	
	NameCounter := NameCounter + 1.
	^NameCounter
]

{ #category : #accessing }
SoulFactory class >> uniqueName [
	
	^'Var' , self uniqueCounter asString
]

{ #category : #'symbiotic clause support' }
SoulFactory >> collectionMemberBlockWithTermPointer: aTermPointer andEnvironment: anEnvironment [
	"Returns block to be used in symbiotic implementation of collectionMember/2 clause. Called at run-time. Specialized for fuzzy logic. "

	
	^self subclassResponsibility
]

{ #category : #'annotated terms' }
SoulFactory >> defaultAnnotation [
	"The default annotation for terms for which no annotation is provided."

	
	^self subclassResponsibility
]

{ #category : #evaluators }
SoulFactory >> evaluatorForLogicQuery [
	
	^self subclassResponsibility
]

{ #category : #evaluators }
SoulFactory >> evaluatorForTemplateCompilation [
	
	^self subclassResponsibility
]

{ #category : #evaluators }
SoulFactory >> evaluatorForTemplateParsing [
	
	^self subclassResponsibility
]

{ #category : #testing }
SoulFactory >> isCrispLogic [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeAndClause [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeAnnotatedTerm [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeBinding [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeCallTerm [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeChoiceFrame [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeClauseClause [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeCompound [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeConstant [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeCut [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeDelayedVariable [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeEmptyList [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeEnvLookupClause [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeEnvironment [
	
	^self subclassResponsibility
]

{ #category : #hornClauses }
SoulFactory >> makeFact [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeFrame [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeGetEnvClause [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeGetRepositoryClause [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeHiddenVariable [
	
	^self subclassResponsibility
]

{ #category : #hornClauses }
SoulFactory >> makeHornClause [
	
	^self subclassResponsibility
]

{ #category : #repository }
SoulFactory >> makeImportRepository [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeKeywordFunctor [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeList [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeMessageFunctor [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeMessageTerm [
	
	^self subclassResponsibility
]

{ #category : #parser }
SoulFactory >> makeMethodParser [
	
	^self subclassResponsibility
]

{ #category : #visitors }
SoulFactory >> makeNamedVariableVisitor [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeNativeResolver [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeNegVariable [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeNotClause [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeOrClause [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makePair [
	
	^self subclassResponsibility
]

{ #category : #parser }
SoulFactory >> makeParser [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makePosVariable [
	
	^self subclassResponsibility
]

{ #category : #hornClauses }
SoulFactory >> makeProgramSequence [
	
	^self subclassResponsibility
]

{ #category : #hornClauses }
SoulFactory >> makeQuery [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeQuotedCodeConstant [
	
	^self subclassResponsibility
]

{ #category : #parser }
SoulFactory >> makeQuotedCodeParser [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeQuotedCodeTerm [
	
	^self subclassResponsibility
]

{ #category : #repository }
SoulFactory >> makeRepository [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeResolutionResult [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeResolver [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeResultMessageTerm [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeResults [
	
	^self subclassResponsibility
]

{ #category : #hornClauses }
SoulFactory >> makeRule [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeRuleSelector [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeSetResolverClause [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeSmalltalkTerm [
	
	^self subclassResponsibility
]

{ #category : #parser }
SoulFactory >> makeSmalltalkTermParser [
	
	^self subclassResponsibility
]

{ #category : #kernel }
SoulFactory >> makeStack [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeTemplateQuery [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeTermSequence [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeUnaryMessageFunctor [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeUnderscoreVariable [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeUppedObject [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeVarArgsCompound [
	
	^self subclassResponsibility
]

{ #category : #terms }
SoulFactory >> makeVariable [
	
	^self subclassResponsibility
]

{ #category : #visitors }
SoulFactory >> makeVariableAndUnderscoreVariableVisitor [
	
	^self subclassResponsibility
]

{ #category : #'native clauses' }
SoulFactory >> makeWriteToPrologClause [
	
	^self subclassResponsibility
]

{ #category : #'progress notification' }
SoulFactory >> progressNotificationClass [
	
	^self subclassResponsibility
]
