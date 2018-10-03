"
This class represents the quotedcode in a logic program
"
Class {
	#name : #QuotedCodeTerm,
	#superclass : #SymbiosisTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'signal constants' }
QuotedCodeTerm class >> errorSignal [
	
	^SoulParseError
]

{ #category : #visitor }
QuotedCodeTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor quotedCodeTermVisit: self
]

{ #category : #quotedCode }
QuotedCodeTerm >> asSourceStringIn: anEnv startAt: anIndex [
	
	^self evaluateIn: anEnv startAt: anIndex
]

{ #category : #private }
QuotedCodeTerm >> compactedContent [
	
	| newContent previous string |
	newContent := OrderedCollection new.
	previous := WriteStream on: String new.
	content
		do:
			[:el | 
			string := el smalltalkBlockString.
			string size = 3
				ifTrue: [previous nextPut: (string at: 2)]
				ifFalse:
					[newContent add: (QuotedCodeConstant name: previous contents).
					previous := WriteStream on: String new.
					newContent add: el]].
	previous contents size > 0
		ifTrue: [newContent add: (QuotedCodeConstant name: previous contents)].
	^newContent
]

{ #category : #private }
QuotedCodeTerm >> constructBlock [
	"This method constructs the SmalltalkBlock to be executed if the  
	quotedcode needs to be downed to a string"

	
	| sourceCode blockNode temporaries statements compactedContent |
	compactedContent := self compactedContent.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: '[:env :envIndex '.
	variables size > 2
		ifTrue:
			[(3 to: variables size)
				do:
					[:index | sourceCode nextPutAll: ':arg' , (variables at: index) name , ' ']].
	sourceCode nextPutAll: ' | '.
	compactedContent isEmpty
		ifTrue: [sourceCode nextPutAll: '''''']
		ifFalse:
			[compactedContent
				do: [:el | sourceCode nextPutAll: el smalltalkBlockString]
				separatedBy: [sourceCode nextPutAll: ' , ']].
	sourceCode nextPutAll: ']'.
	variables size > 2
		ifTrue:
			[blockNode := RBParser parseExpression: sourceCode contents.
			statements := blockNode body statements asOrderedCollection.
			temporaries := blockNode body temporaries asOrderedCollection.
			(3 to: variables size)
				do:
					[:index | 
					temporaries
						add: (RBVariableNode named: 'soulvar' , (variables at: index) name)].
			(3 to: variables size)
				do:
					[:index | 
					statements
						addFirst:
							(RBParser
								parseExpression:
									'soulvar' , (variables at: index) name , ' := ' , 'arg'
										, (variables at: index) name ,
											' asSourceStringIn: env startAt: envIndex.')].
			blockNode body statements: statements.
			blockNode body temporaries: temporaries.
			block := self compilerForSmalltalkTermBlocks
				evaluate: blockNode formattedCode]
		ifFalse:
			[block := self compilerForSmalltalkTermBlocks evaluate: sourceCode contents]
]

{ #category : #private }
QuotedCodeTerm >> parse [
	
	content := source isEmpty
		ifTrue: [#()]
		ifFalse:
			[SoulFactory current makeQuotedCodeParser
				parse: source
				onError:
					[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]]
]

{ #category : #private }
QuotedCodeTerm >> parseVariables [
	
	| dict visitor |
	variables := OrderedCollection new.
	dict := Dictionary new.
	visitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			dict
				at: var name
				ifAbsentPut:
					[variables addLast: var.
					var]].
	content do: [:each | each accept: visitor].
	variables addFirst: nil.
	variables addFirst: nil.
	variables := variables asArray
]

{ #category : #printing }
QuotedCodeTerm >> prettyPrintOn: aStream scope: id [

	aStream withAttributes:(Array with:(TextColor color:(Color r:0 g:0 b:256)) with:(TextEmphasis bold)) do:[aStream write: '{'.].
	super prettyPrintOn: aStream scope: id.
	aStream withAttributes:(Array with:(TextColor color:(Color r:0 g:0 b:256)) with:(TextEmphasis bold)) do:[aStream write: '}'.].
]

{ #category : #printing }
QuotedCodeTerm >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' source: '.
	source printOn: aStream
]

{ #category : #printing }
QuotedCodeTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: '{'.
	aStream write: source.
	aStream write: '}'
]

{ #category : #resolving }
QuotedCodeTerm >> resolveIn: anEnv startAt: anIndex [
	
	| term visitor |
	term := (SoulFactory current makeParser
		parse: source
		onError: [self error: 'cannot parse contents as a soul term']) clauses
		first conclusion.
	visitor := FixVisitor new addVariables: self variables.
	term accept: visitor.
	term definitionRepository: self definitionRepository.
	^term resolveIn: anEnv startAt: anIndex
]

{ #category : #reification }
QuotedCodeTerm >> soulDownIn: anEnv startAt: anIndex [
	"DownedQuotedCode represents the QuotedCode construct on the  
	smalltalk-level. We also down our contents to allow an up later on"

	
	| string newcontent newvariables |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [(el soulDownIn: anEnv startAt: anIndex) soulUp]].
	newcontent := content
		collect: [:el | (el soulDownIn: anEnv startAt: anIndex) soulUp].
	^DownedQuotedCode fromString: string variables: newvariables content:
			newcontent block: block
]

{ #category : #reification }
QuotedCodeTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	
	| string newvariables newcontent |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el transitiveLookupIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | el transitiveLookupIn: anEnv startAt: anIndex].
	^QuotedCodeTerm source: string variables: newvariables content: newcontent
		block: block
]

{ #category : #unification }
QuotedCodeTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithQuotedCodeTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"a quotedCode unifies with a compound in the following way:
	{a b c d} <-> <a,b,c,d>
	{a ?b c ?d} <-> <a,?b,c,?d>(?b,?d)"

	
	| vars otherTerms |
	vars := self variables.
	vars size == aCompound multiplicity
		ifTrue:
			[otherTerms := aCompound termSequence terms.
			vars
				with: otherTerms
				do:
					[:myTerm :otherTerm | 
					(otherTerm
						unifyWith: myTerm
						inEnv: anEnv
						myIndex: hisIndex
						hisIndex: myIndex
						inSource: (inSource xor: true)) ifFalse: [^false]].
			^aCompound functor
				unifyWith:
					(SoulFactory current makeList
						termSequence:
							(TermSequence new terms: (content collect: [:each | each quotedCodeToList])))
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]
		ifFalse: [^false]
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"TODO: how to unify quotedCode? Currently we, compare strings. An  
	alternative is in the comment"

	"a quotedCode unifies with another quotedCode if all subterms unify  
	| index succes |  
	succes _ true.  
	index _ 1.  
	self terms size == aQCTerm terms size  
	ifFalse: [^ false].  
	aQCTerm terms  
	do: [:otherTerm |  
	succes  
	ifTrue: [succes _ otherTerm  
	unifyWith: (content at: index)  
	inEnv: anEnv].  
	index _ index + 1].  
	^ succes"

	
	^(self asSourceStringIn: anEnv startAt: myIndex)
		= (aQCTerm asSourceStringIn: anEnv startAt: hisIndex)
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithSmalltalkTerm: aSTTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^(aSTTerm evaluateIn: anEnv startAt: targetIndex) soulUp
		unifyWithQuotedCodeTerm: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: inSource not
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject unifyWithQuotedCodeTerm: self inEnv: anEnv myIndex: targetIndex
		hisIndex: sourceIndex inSource: inSource
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	| value |
	value := anObject smalltalkValue.
	value ifNil: [^false].
	^(self asSourceStringIn: anEnv startAt: sourceIndex) match: value
]

{ #category : #unification }
QuotedCodeTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"a quotedCode unifies with a variable by binding to this variable or 
	unifying with it's binding"

	
	| val |
	val := anEnv lookup: aVariable startAt: hisIndex.
	val isNil
		ifTrue:
			[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithQuotedCodeTerm: self
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]
]
