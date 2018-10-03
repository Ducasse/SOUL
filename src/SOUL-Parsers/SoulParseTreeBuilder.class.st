Class {
	#name : #SoulParseTreeBuilder,
	#superclass : #Object,
	#instVars : [
		'parser'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'instance creation' }
SoulParseTreeBuilder class >> forParser: parser [
	
	^super new forParser: parser
]

{ #category : #'instance creation' }
SoulParseTreeBuilder class >> new [
	
	^self forParser: nil
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> addKeyword: keyword andArg: argument to: keywordMessageCompound [
	
	^keywordMessageCompound addKeyword: keyword term: argument
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> addKeyword: keyword term: term toKeywordedCompound: compound [
	
	^compound addKeyword: keyword term: term
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> addTabledRules: aSoulTabledProgramSequence inFront: aSoulProgramSequence [
	
	^aSoulTabledProgramSequence addAll: aSoulProgramSequence
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> addTerm: aTerm inFront: aTermSequence [
	
	^aTermSequence addTermFirst: aTerm
]

{ #category : #private }
SoulParseTreeBuilder >> allAfter: anObject in: aCollection [
	
	| startIndex |
	startIndex := aCollection indexOf: anObject.
	^aCollection
		copyFrom: startIndex + 1
		to: aCollection size
]

{ #category : #private }
SoulParseTreeBuilder >> allBefore: anObject in: aCollection [
	"| stopIndex |
	stopIndex := aCollection indexOf: anObject."

	
	^aCollection copyUpTo: anObject
]

{ #category : #'building annotated SOUL' }
SoulParseTreeBuilder >> buildAnnotatedTerm: aTerm withAnnotation: anAnnotationTerm [
	
	^SoulFactory current makeAnnotatedTerm term: aTerm annotation:
			anAnnotationTerm
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildCallTerm: aTerm variable: aVariable [
	"I made a mistake in the parser generation... the actual arguments that are passed are switched with respect to the keywords..."

	
	^SoulFactory current makeCallTerm variable: aVariable term: aTerm
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildCompound: aFunctor withTerms: aTermSequence [
	
	^SoulFactory current makeCompound functor: aFunctor termSequence:
			aTermSequence
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildConstant: anIdentifierString [
	
	^SoulFactory current makeConstant name: anIdentifierString asSymbol
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildCut [
	
	^SoulFactory current makeCut new
]

{ #category : #DCG }
SoulParseTreeBuilder >> buildDCGRule: head body: body [
	
	^DCGRule condition: body conclusion: head
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildDecoratedVariable: aName with: aCollectionOfConstants [
	
	^(DecoratedVariable name: (aName allButFirst: 1)) decorators:
			aCollectionOfConstants
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildDelayedVariable: anIdentifierString [
	
	^SoulFactory current makeDelayedVariable
		name: (anIdentifierString allButFirst: 1)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildEmptyList [
	
	^SoulFactory current makeEmptyList new
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildEmptyList: identifier [
	
	^SoulFactory current makeEmptyList new
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildFact: aTerm [
	
	^(SoulFactory current makeFact conclusion: aTerm)
		comment: self lastComments;
		yourself
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildKeyword: anIdentifierString [
	
	^SoulFactory current makeConstant
		name: (anIdentifierString allButLast: 1) asSymbol
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildKeywordedCompound: keyword firstTerm: term [
	
	^SoulFactory current makeMessageTerm
		functor: (SoulFactory current makeKeywordFunctor keyword: keyword)
		termSequence: (self buildTermSequence: term)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildKeywordedMessageFirstKey: keyword andArgument: argument [
	
	^SoulFactory current makeMessageTerm
		functor: (SoulFactory current makeMessageFunctor keyword: keyword)
		termSequence: (self buildTermSequence: argument)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildKeywordedMessageReceiver: receiver message: keywordedMessageCompound [
	
	^keywordedMessageCompound addTermFirst: receiver
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildList: aTermSequence [
	"take a look at this... we should avoid unwrapping of the collection"

	
	^SoulFactory current makeList termSequence: aTermSequence
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildNegVariable: anIdentifierString [
	
	^SoulFactory current makeNegVariable name: (anIdentifierString allButFirst: 2)
]

{ #category : #DCG }
SoulParseTreeBuilder >> buildNormalbody: aBody on: aStream [
	
	| counter |
	counter := 1.
	aBody terms
		do:
			[:aTerm | 
			aTerm printOn: aStream.
			aStream
				skip: -1;
				write: ',?tokens' , counter asString.
			counter := counter + 1.
			aStream write: ',?tokens' , counter asString , ')']
		separatedBy: [aStream write: ',']
]

{ #category : #DCG }
SoulParseTreeBuilder >> buildOldDCGRule: head body: body [
	"Convert a DCG spec to a logic rule:
		s(a,b) --> np(a),vp(b)   ==>>  s(a,b,L1,L3) if np(a,L1,L2),vp(b,L2,L3)"

	
	| aStream |
	aStream := WriteStream on: String new.
	head printOn: aStream.
	head multiplicity > 0
		ifTrue:
			[aStream skip: -1.
			aStream write: ',']
		ifFalse: [aStream write: '('].
	aStream
		write: '?tokens1,?tokens' , (body terms size + 1) asString , ') if '.
	self convertDirectRuleCalls: body.
	body terms size = 1
		& (body terms first isKindOf: SoulFactory current makeList)
		ifTrue: [self buildTerminalbody: body on: aStream]
		ifFalse: [self buildNormalbody: body on: aStream].
	^(SoulFactory current makeParser
		parse: aStream contents
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString])
		clauses first
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildPair: aTermSequence cdr: aTerm [
	"take a look at this... we should avoid unwrapping of the collection"

	
	^SoulFactory current makePair new
		addChildrenInitial:
			((OrderedCollection new)
				add: aTermSequence;
				add: aTerm;
				yourself)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildPosVariable: anIdentifierString [
	
	^SoulFactory current makePosVariable name: (anIdentifierString allButFirst: 2)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildProgramSequence: aHornClause [
	
	^SoulFactory current makeProgramSequence new addTermFirst: aHornClause
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildQuery: anObject [
	
	^SoulFactory current makeQuery condition: anObject
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildQuotedCodeConstant: aString [
	
	^SoulFactory current makeQuotedCodeConstant name: aString asSymbol
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildQuotedCodeTerm: source [
	
	^SoulFactory current makeQuotedCodeTerm
		source:
			(source
				copyFrom: 2
				to: source size - 1)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildRegexMessageReceiver: receiver message: keywordedMessageCompound [
	
	| term |
	term := RegexTerm newFromMessageTerm: keywordedMessageCompound withGoals:
			receiver.
	^term generateStates
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildResultMessageTerm: message resultTerm: result [
	
	^SoulFactory current makeResultMessageTerm message: message result: result
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildRuleConclusion: aTerm condition: aTermSequence [
	
	^(SoulFactory current makeRule condition: aTermSequence conclusion: aTerm)
		comment: self lastComments;
		yourself
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildSmalltalkTerm: source [
	
	^SoulFactory current makeSmalltalkTerm
		source:
			(source
				copyFrom: 2
				to: source size - 1)
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildSpliceCompound: aString [
	
	| result |
	result := SoulFactory current makeParser
		parse: (aString allButFirst: 1)
		onError: [:ex :id | self error: ex , ' at ' , id asString].
	^result clauses first conclusion	"asApplyCompound"
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildSymbol: anIdentifierString [
	
	^SoulFactory current makeConstant
		name:
			(anIdentifierString
				copyFrom: 2
				to: anIdentifierString size) asSymbol
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildTabledProgramSequence: aSoulProgramSequence [
	
	^aSoulProgramSequence
]

{ #category : #SLG }
SoulParseTreeBuilder >> buildTabledRule: aSoulRule [
	
	^aSoulRule
		asTabledRuleWithConditionString: aSoulRule condition asString
]

{ #category : #SLG }
SoulParseTreeBuilder >> buildTabledRuleBackup: aSoulRule [
	
	| sequence |
	sequence := self buildProgramSequence: (self slgCallRuleFor: aSoulRule).
	sequence clauses addAll: (self slgImplementationRulesFor: aSoulRule).
	^sequence
]

{ #category : #'building SmalltalkTerm/QuotedCode' }
SoulParseTreeBuilder >> buildTemplateQuery: source type: aType [
	^ SoulFactory current makeTemplateQuery source: (source copyFrom: 2 to: source size - 1) type: aType
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildTermSequence: aTerm [
	
	^SoulFactory current makeTermSequence new addTermFirst: aTerm
]

{ #category : #DCG }
SoulParseTreeBuilder >> buildTerminalbody: aBody on: aStream [
	
	aStream write: 'equals(?tokens1,'.
	aBody terms first printOn: aStream.
	aStream skip: -1.
	aStream write: ' | ?tokens2>)'
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildUnaryMessageFromId: id [
	
	^SoulFactory current makeUnaryMessageFunctor message: (self buildConstant: id)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildUnaryMessageFromVariable: var [
	
	^SoulFactory current makeUnaryMessageFunctor message: var
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildUnaryMessageReceiver: receiver message: message [
	
	^SoulFactory current makeMessageTerm
		functor: message
		termSequence: (SoulFactory current makeTermSequence term: receiver)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildUnderscoreVariable: anIdentifierString [
	
	^SoulFactory current makeUnderscoreVariable new
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildVarArgsCompound: aFunctor withTerms: aTermSequence [
	
	^SoulFactory current makeVarArgsCompound functor: aFunctor termSequence:
			aTermSequence
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildVarKeyword: anIdentifierString [
	
	^SoulFactory current makeVariable
		name: ((anIdentifierString allButFirst: 1) allButLast: 1)
]

{ #category : #'building SOUL' }
SoulParseTreeBuilder >> buildVariable: anIdentifierString [
	
	^SoulFactory current makeVariable name: (anIdentifierString allButFirst: 1)
]

{ #category : #DCG }
SoulParseTreeBuilder >> convertDirectRuleCalls: aBody [
	"Process the direct calls to logic rules. They are embedded in quotedcode terms... a little bit of a mis-usage, but it works ;-)"

	
	| newTerms |
	newTerms := aBody terms
		collect:
			[:aClause | 
			(aClause isKindOf: QuotedCodeTerm)
				ifTrue:
					[SoulFactory current makeParser
						parse: aClause source
						onError: [:a :b | self error: 'Something went terribly wrong!']]
				ifFalse: [aClause]].
	aBody terms: newTerms
]

{ #category : #SLG }
SoulParseTreeBuilder >> detectTabledCallIn: aTermCollection using: aConclusion [
	
	| myLiteral |
	myLiteral := aConclusion predicate , aConclusion multiplicity asString.	"Check if the conditions contain a recursive call or a call to a tabled predicate. TODO: check for tabled predicate too"

	^aTermCollection
		detect:
			[:aCondition | 
			(aCondition functor printString , aCondition multiplicity printString) =
					myLiteral]
		ifNone: [nil]
]

{ #category : #SLG }
SoulParseTreeBuilder >> environmentVariablesForCallTerm: aCallOfTabledPredicate inRuleWithConclusion: aConclusion termsBefore: beforeCollection termsAfter: afterCollection [
	"TODO: should be possible to capture the actual environment instead"

	
	| left right lfree rfree varsintersected |
	left := OrderedCollection new.
	left addAll: beforeCollection.
	left add: aConclusion.
	lfree := self variableNamesIn: (TermSequence terms: left).
	right := OrderedCollection new.
	right addAll: afterCollection.
	right add: aConclusion.
	right add: aCallOfTabledPredicate.
	rfree := self variableNamesIn: (TermSequence terms: right).
	varsintersected := (lfree select: [:v | rfree includes: v])
		asOrderedCollection.
	^ListTerm
		newFromCollection:
			(varsintersected collect: [:name | Variable name: name])
]

{ #category : #initialization }
SoulParseTreeBuilder >> forParser: aParser [
	
	parser := aParser
]

{ #category : #'comment handling' }
SoulParseTreeBuilder >> lastComments [
	
	^parser
		ifNil: ['']
		ifNotNil: [parser giveAndWipeComment]
]

{ #category : #SLG }
SoulParseTreeBuilder >> slgAnswerRuleFor: originalSoulTerm sequenceNr: anInteger callTerm: resultTerm conditions: aTermCollection environmentVariables: vars [
	
	| answer |
	answer := originalSoulTerm conclusion.
	^(SoulFactory current makeParser
		parse:
			originalSoulTerm predicate , 'cont' , anInteger asString , '(?Id,'
				, vars asString , ',' , resultTerm asString , ',D) if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					'answer(?Id,' , answer asString , ',D)'
		onError: [:e :p | self halt]) clauses first
]

{ #category : #SLG }
SoulParseTreeBuilder >> slgCallRuleFor: aSoulRule [
	
	| literal |
	literal := aSoulRule conclusion printString.
	^(SoulFactory current makeParser
		parse: literal , ' if slg(' , literal , ')'
		onError: [:a :b | self error: 'Something went terribly wrong!']) clauses
		first asTabledRuleWithConditionString: aSoulRule condition displayString
]

{ #category : #SLG }
SoulParseTreeBuilder >> slgContinuationRulesFor: originalSoulRule sequenceNr: anInteger callTerm: resultTerm remainingConditions: aTermCollection endVars: endVars [
	
	| tabledCall splitIndex ownConditions contConditions rules vars |
	tabledCall := self
		detectTabledCallIn: aTermCollection
		using: originalSoulRule conclusion.
	tabledCall isNil
		ifTrue:
			[^OrderedCollection
				with:
					(self slgAnswerRuleFor: originalSoulRule sequenceNr: anInteger callTerm:
							resultTerm conditions: aTermCollection environmentVariables: endVars)]
		ifFalse:
			[splitIndex := aTermCollection indexOf: tabledCall.
			ownConditions := splitIndex = 1
				ifTrue: [ownConditions := OrderedCollection new]
				ifFalse: [aTermCollection copyUpTo: splitIndex - 1].
			contConditions := aTermCollection
				copyFrom: splitIndex + 1
				to: aTermCollection size.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: originalSoulRule conclusion
				termsBefore: ownConditions
				termsAfter: contConditions.
			rules := self
				slgContinuationRulesFor: originalSoulRule
				sequenceNr: anInteger + 1
				callTerm: tabledCall
				remainingConditions: contConditions
				endVars: vars copy.	"rules
				addFirst: (Soul.Factory current makeParser
						parse: originalSoulRule predicate , 'cont' , anInteger asString
								, '(?Id,?Vars,' , resultTerm asString
								, ',D) if ' , (TermSequence terms: ownConditions) printString
						onError: [:e | self halt]) clauses
						first."

			rules
				addFirst:
					(SoulFactory current makeParser
						parse:
							originalSoulRule predicate , 'cont' , anInteger asString , '(?Id,'
								, endVars asString , ',' , resultTerm asString , ',D) if '
								, (TermSequence terms: ownConditions) printString , 'slgcall(?Id, '
								, vars asString , ',' , tabledCall printString , ',0,'
								, (originalSoulRule predicate , 'cont' , (anInteger + 1) asString)
								, ')'
						onError: [:e | self halt]) clauses first.
			^rules]
]

{ #category : #SLG }
SoulParseTreeBuilder >> slgImplementationRulesFor: aSoulRule [
	
	| tabledCall rules conclusionString ruleString previousConditionsString remainingConditions previousConditions vars |
	conclusionString := 'slg'
		, (aSoulRule conclusion printString allButLast: 1) , ',?Id)'.
	tabledCall := self
		detectTabledCallIn: aSoulRule condition terms
		using: aSoulRule conclusion.
	tabledCall isNil
		ifTrue:
			[ruleString := conclusionString , ' if ' , aSoulRule condition printString
				, ',answer(?Id,' , aSoulRule conclusion printString , ',0)'.
			rules := OrderedCollection new]
		ifFalse:
			["If a call to a tabled predicate (or a recursive call is present)"

			remainingConditions := self
				allAfter: tabledCall
				in: aSoulRule condition terms.
			previousConditions := self
				allBefore: tabledCall
				in: aSoulRule condition terms.
			vars := self
				environmentVariablesForCallTerm: tabledCall
				inRuleWithConclusion: aSoulRule conclusion
				termsBefore: previousConditions
				termsAfter: remainingConditions.
			rules := self slgContinuationRulesFor: aSoulRule sequenceNr: 0 callTerm:
					tabledCall remainingConditions: remainingConditions endVars: vars.
			previousConditionsString := (TermSequence terms: previousConditions)
				printString.
			previousConditionsString = ''
				ifFalse: [previousConditionsString := previousConditionsString , ','].
			ruleString := conclusionString , ' if ' , previousConditionsString ,
					'slgcall(?Id, ' , vars asString , ',' , tabledCall printString , ',0,'
				, aSoulRule predicate asString , 'cont0)'].
	rules
		addFirst:
			(SoulFactory current makeParser
				parse: ruleString
				onError: [:a :b | self error: 'Something went terribly wrong!'])
				clauses first.
	^rules
]

{ #category : #SLG }
SoulParseTreeBuilder >> variableNamesIn: aTerm [
	
	| dict variableVisitor |
	dict := Dictionary new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			var isHiddenVariable
				ifFalse:
					[dict
						at: var name asSymbol
						ifAbsentPut: [var name asSymbol]]].
	aTerm accept: variableVisitor.
	^dict values asSet
]
