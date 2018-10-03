Class {
	#name : #StandardSoulFactory,
	#superclass : #SoulFactory,
	#category : 'SOUL-Kernel'
}

{ #category : #'initialize-release' }
StandardSoulFactory class >> initialize [
	
	super initialize.
	super initialize: self new
]

{ #category : #'symbiotic clause support' }
StandardSoulFactory >> collectionMemberBlockWithTermPointer: aTermPointer andEnvironment: anEnvironment [
	"Returns block to be used in symbiotic implementation of collectionMember/2 clause. Called at run-time. Specialized for fuzzy logic such that the unification degree of the first argument with an element of the collection is taken into account. "

	
	^[:anArg | 
	| hisIndex |
	hisIndex := anEnvironment startUnify: 0.
	(aTermPointer term soulUp
		unifyWith: anArg soulUp
		inEnv: anEnvironment
		myIndex: aTermPointer envIndex
		hisIndex: hisIndex
		inSource: false)
		ifTrue:
			[SoulFactory current makeResolutionResult
				condition: OrderedCollection new
				rollbackInfo: anEnvironment rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]
		ifFalse:
			[anEnvironment rollback.
			nil]]
]

{ #category : #'annotated terms' }
StandardSoulFactory >> defaultAnnotation [
	"The default annotation for terms for which no annotation is provided, only used for generalized annotated logic or fuzzy logics."

	
	^1 soulUp
]

{ #category : #evaluators }
StandardSoulFactory >> evaluatorForLogicQuery [
	
	^SoulEvaluator
]

{ #category : #evaluators }
StandardSoulFactory >> evaluatorForTemplateCompilation [
	
	^self evaluatorForLogicQuery
]

{ #category : #evaluators }
StandardSoulFactory >> evaluatorForTemplateParsing [
	
	^self evaluatorForLogicQuery
]

{ #category : #testing }
StandardSoulFactory >> isCrispLogic [
	
	^true
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeAndClause [
	
	^AndClause
]

{ #category : #terms }
StandardSoulFactory >> makeAnnotatedTerm [
	
	^AnnotatedTerm
]

{ #category : #terms }
StandardSoulFactory >> makeCallTerm [
	
	^CallTerm
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeClauseClause [
	
	^ClauseClause
]

{ #category : #terms }
StandardSoulFactory >> makeCompound [
	
	^CompoundTerm
]

{ #category : #terms }
StandardSoulFactory >> makeConstant [
	
	^Constant
]

{ #category : #hornClauses }
StandardSoulFactory >> makeCut [
	
	^Cut
]

{ #category : #terms }
StandardSoulFactory >> makeDelayedVariable [
	
	^DelayedVariable
]

{ #category : #terms }
StandardSoulFactory >> makeEmptyList [
	
	^EmptyListConstant
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeEnvLookupClause [
	
	^EnvLookupClause
]

{ #category : #kernel }
StandardSoulFactory >> makeEnvironment [
	
	^Environment
]

{ #category : #hornClauses }
StandardSoulFactory >> makeFact [
	
	^Fact
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeGetEnvClause [
	
	^GetEnvClause
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeGetRepositoryClause [
	
	^GetRepositoryClause
]

{ #category : #terms }
StandardSoulFactory >> makeHiddenVariable [
	
	^HiddenVariable
]

{ #category : #hornClauses }
StandardSoulFactory >> makeHornClause [
	
	^HornClause
]

{ #category : #terms }
StandardSoulFactory >> makeKeywordFunctor [
	
	^KeywordFunctor
]

{ #category : #terms }
StandardSoulFactory >> makeList [
	
	^ListTerm
]

{ #category : #terms }
StandardSoulFactory >> makeMessageFunctor [
	
	^MessageFunctor
]

{ #category : #terms }
StandardSoulFactory >> makeMessageTerm [
	
	^MessageTerm
]

{ #category : #parsers }
StandardSoulFactory >> makeMethodParser [
	
	^SoulMethodCompiler
]

{ #category : #visitors }
StandardSoulFactory >> makeNamedVariableVisitor [
	
	^NamedVariableVisitor
]

{ #category : #kernel }
StandardSoulFactory >> makeNativeResolver [
	
	^NativeResolver
]

{ #category : #terms }
StandardSoulFactory >> makeNegVariable [
	
	^NegVariable
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeNotClause [
	
	^NotClause
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeOrClause [
	
	^OrClause
]

{ #category : #terms }
StandardSoulFactory >> makePair [
	
	^PairTerm
]

{ #category : #parsers }
StandardSoulFactory >> makeParser [
	
	^SoulParser
]

{ #category : #terms }
StandardSoulFactory >> makePosVariable [
	
	^PosVariable
]

{ #category : #hornClauses }
StandardSoulFactory >> makeProgramSequence [
	
	^ProgramSequence
]

{ #category : #hornClauses }
StandardSoulFactory >> makeQuery [
	
	^Query
]

{ #category : #terms }
StandardSoulFactory >> makeQuotedCodeConstant [
	
	^QuotedCodeConstant
]

{ #category : #parsers }
StandardSoulFactory >> makeQuotedCodeParser [
	
	^QuotedCodeParser
]

{ #category : #terms }
StandardSoulFactory >> makeQuotedCodeTerm [
	
	^QuotedCodeTerm
]

{ #category : #repository }
StandardSoulFactory >> makeRepository [
	
	^LogicRepository
]

{ #category : #kernel }
StandardSoulFactory >> makeResolutionResult [
	
	^ResolutionResult
]

{ #category : #kernel }
StandardSoulFactory >> makeResolver [
	
	^Resolver
]

{ #category : #terms }
StandardSoulFactory >> makeResultMessageTerm [
	
	^ResultMessageTerm
]

{ #category : #kernel }
StandardSoulFactory >> makeResults [
	
	^Results
]

{ #category : #hornClauses }
StandardSoulFactory >> makeRule [
	
	^Rule
]

{ #category : #kernel }
StandardSoulFactory >> makeRuleSelector [
	
	^DepthFirstRuleSelector
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeSetResolverClause [
	
	^SetResolverClause
]

{ #category : #terms }
StandardSoulFactory >> makeSmalltalkTerm [
	
	^SmalltalkTerm
]

{ #category : #parsers }
StandardSoulFactory >> makeSmalltalkTermParser [
	
	^SmalltalkTermParser
]

{ #category : #terms }
StandardSoulFactory >> makeTemplateQuery [
	
	^TemplateQueryTerm
]

{ #category : #terms }
StandardSoulFactory >> makeTermSequence [
	
	^TermSequence
]

{ #category : #terms }
StandardSoulFactory >> makeUnaryMessageFunctor [
	
	^UnaryMessageFunctor
]

{ #category : #terms }
StandardSoulFactory >> makeUnderscoreVariable [
	
	^UnderscoreVariable
]

{ #category : #terms }
StandardSoulFactory >> makeUppedObject [
	
	^UppedObject
]

{ #category : #terms }
StandardSoulFactory >> makeVarArgsCompound [
	
	^VarArgsCompoundTerm
]

{ #category : #terms }
StandardSoulFactory >> makeVariable [
	
	^Variable
]

{ #category : #visitors }
StandardSoulFactory >> makeVariableAndUnderscoreVariableVisitor [
	
	^VariableAndUnderscoreVariableVisitor
]

{ #category : #'native clauses' }
StandardSoulFactory >> makeWriteToPrologClause [
	
	^WriteToPrologClause
]

{ #category : #'progress notification' }
StandardSoulFactory >> progressNotificationClass [
	
	^Notice
]
