"
This abstract class is the superclass of all logic terms that deal with symbiosis with Smalltalk. It groups their common behaviour

Subclasses must implement the following messages:
	private
		constructBlock
		parse:
		parseVariables

Instance Variables:
	block	<BlockClosure | MessageChannel>	description of block
	content	<RBProgramNode>	description of content
	source	<AbstractItem | ByteFieldDescriptor | CCompoundType | (Collection of: Character) | MC_FileBTree | PostgreSQLQueryResultList | RBProgramNode | SmaCCRHS | SOULResults | Stream | TermSequence>	description of source
	variables	<(OrderedCollection of: Variable)>	description of variables


"
Class {
	#name : #SymbiosisTerm,
	#superclass : #ResolvableTerm,
	#instVars : [
		'source',
		'block',
		'variables',
		'content'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
SymbiosisTerm class >> source: aString [
	
	^self new source: aString
]

{ #category : #'instance creation' }
SymbiosisTerm class >> source: aString variables: aCollection content: aContent block: aBlock [
	
	^self new source: aString variables: aCollection content: aContent block:
			aBlock
]

{ #category : #converting }
SymbiosisTerm >> asDCGConditionFor: aCounter [
	
	| tokens1var tokens2var equals |
	tokens1var := SoulFactory current makeVariable
		name: 'tokens' , aCounter asString.
	tokens2var := SoulFactory current makeVariable
		name: 'tokens' , (aCounter + 1) asString.
	equals := SoulFactory current makeCompound
		functor: (Constant name: #equals)
		termSequence:
			(TermSequence terms: (OrderedCollection with: tokens1var with: tokens2var)).
	^SoulFactory current makeCompound
		functor: (Constant name: #and)
		termSequence:
			(TermSequence terms: (OrderedCollection with: self with: equals))
]

{ #category : #access }
SymbiosisTerm >> block [
	"This is the block to be evaluated when trying to resolve a symbiosisterm"

	
	^block
]

{ #category : #private }
SymbiosisTerm >> compilerForSmalltalkTermBlocks [
	"TODO: Find a cleaner way to do make this Squeak compatible. Pass by the MLI which already has VW and Squeak-specific specializations?"

	
	^ClosureCompiler
		ifNil: [self class compilerClass]
		ifNotNil: [ClosureCompiler]
]

{ #category : #private }
SymbiosisTerm >> constructBlock [
	
	self subclassResponsibility
]

{ #category : #access }
SymbiosisTerm >> content [
	"This method returns the internal content, as it was parsed"

	
	^content
]

{ #category : #access }
SymbiosisTerm >> evaluateIn: anEnv startAt: anIndex [
	"we need to evaluate the block for this term. unbound variables should be  
	looked up in the environment"

	
	| result |
	variables at: 1 put: anEnv.
	variables at: 2 put: anIndex.
	result := [block valueWithArguments: variables]
		on: UnboundVariableException
		do: [:ex | self].
	variables at: 1 put: nil.
	variables at: 2 put: nil.
	^result
]

{ #category : #slgtesting }
SymbiosisTerm >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToSymbiosisTerm: self
]

{ #category : #slgtesting }
SymbiosisTerm >> isSLGEquivalentToSymbiosisTerm: aSymbiosisTerm [
	
	| val1 val2 |
	"we dont allow them as we can not store them efficiently:
	we either store them with environment + index in the tables (but the env's will be popped/destroyed, so that won't work),
	and we have to constantly evaluate them again in order to get the value"

	self halt:
			'you are using symbiosisterms with tabling... there be dragons here'.
	val1 := aSymbiosisTerm evaluateIn: nil startAt: nil.
	val2 := self evaluateIn: nil startAt: nil.
	^val1 = val2
]

{ #category : #private }
SymbiosisTerm >> parse [
	
	self subclassResponsibility
]

{ #category : #private }
SymbiosisTerm >> parseVariables [
	
	self subclassResponsibility
]

{ #category : #printing }
SymbiosisTerm >> prettyPrintOn: aStream scope: id [
	
	| inVar attribute |

	inVar := false.
	attribute := TextColor black.
	source
		do:
			[:char | 
			"this is ugly... but at least it works fast :-)"

			inVar
				ifTrue:
					[char isAlphaNumeric | char isSymbol
						ifFalse:
							[inVar := false.
							attribute := TextColor black.]].
			char = $? | (char = $&)
				ifTrue:
					[attribute := TextColor color: (Color r:0 g:0 b:256).
					inVar := true].
			aStream withAttribute: attribute do:[aStream write: char]].

]

{ #category : #access }
SymbiosisTerm >> source [
	"This method returns the source code that is encapsulated by the symbiosisterm."

	
	^source
]

{ #category : #initialize }
SymbiosisTerm >> source: aString [
	
	source := aString.
	self parse.
	self parseVariables.
	self constructBlock
]

{ #category : #initialize }
SymbiosisTerm >> source: aString variables: aVarCollection content: aContent block: aBlock [
	
	content := aContent.
	variables := aVarCollection.
	block := aBlock.
	source := aString
]

{ #category : #access }
SymbiosisTerm >> variables [
	"the internal representation of these variables is a collection with nil's on the first two places. They are used for evaluation purposes. This method returns the list of 	variables, to be used for (possible) external usage"

	
	^variables
		copyFrom: 3
		to: variables size
]

{ #category : #access }
SymbiosisTerm >> variablesIncludingNils [
	
	^variables
]
