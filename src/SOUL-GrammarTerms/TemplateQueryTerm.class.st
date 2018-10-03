Class {
	#name : #TemplateQueryTerm,
	#superclass : #QuotedCodeTerm,
	#instVars : [
		'type',
		'parsetrees',
		'queries'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
TemplateQueryTerm class >> source: aString type: aType [
	
	^(self new)
		type: aType;
		source: aString
]

{ #category : #'instance creation' }
TemplateQueryTerm class >> source: string variables: newvariables content: newcontent block: block parsetrees: newparsetree queries: queries type: type [
	
	^self new source: string variables: newvariables content: newcontent
		block: block parsetrees: newparsetree queries: queries type: type
]

{ #category : #visitor }
TemplateQueryTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor templateQueryTermVisit: self
]

{ #category : #private }
TemplateQueryTerm >> asParseTrees [
	"This method is only called after the repository of clauses has been loaded. It parses the contents and builds a set of logic parsetrees of the source, using the DCG grammar rules in the repository."

	
	| results trees |
	results := (SoulFactory current evaluatorForTemplateParsing
		eval:
			'if parse(' , type functor asString , ',[''' , source asString ,
					'''],?result)'
		in: SoulFactory parsingRepository) allResults.
	results size = 0 ifTrue: [self error: 'Parse error in quotedcode'].
	trees := OrderedCollection new.
	results
		do: [:value | trees add: (value accept: CopyingVisitor new)]
		forVariableNames: (OrderedCollection with: 'result').
	^trees
]

{ #category : #private }
TemplateQueryTerm >> asQueries [
	
	| results thesequeries parsetreerepresentation queryclauses conversionQueryString associations |
	thesequeries := OrderedCollection new.
	self parsetrees
		do:
			[:parsetree | 
			parsetreerepresentation := (parsetree accept: VariableWrapperVisitor new)
				asString.
			associations := self associationsForConversionQueryString.
			conversionQueryString := self conversionQueryStringForParseTree:
					parsetreerepresentation.
			results := (SoulFactory current evaluatorForTemplateCompilation
				eval: conversionQueryString
				in: SoulFactory compilingRepository
				withAssociations: associations) allResults.
			results size = 0 ifTrue: [self error: 'conversion error in quotedcode'].
			results
				do:
					[:query :annotation | 
					| evaluator queryCopy annotationCopy |
					queryclauses := OrderedCollection new.
					query listDo: [:aTerm | queryclauses add: aTerm].	"not so nice solution: in order to overcome the shared compound term instances problem in these queries, we create an entirely new query through parsing"

					evaluator := SoulFactory current evaluatorForTemplateCompilation
						eval: (Query condition: (TermSequence terms: queryclauses)) asString
						in: SoulFactory compilingRepository.
					queryCopy := evaluator query condition
						accept: VariableUnwrapperVisitor new.
					annotationCopy := annotation accept: CopyingVisitor new.
					thesequeries add: (Array with: queryCopy with: annotationCopy)]
				forVariableNames: (OrderedCollection with: 'query' with: 'annotation')].
	^thesequeries
]

{ #category : #private }
TemplateQueryTerm >> associationsForConversionQueryString [
	
	| arguments associations |
	arguments := self type termSequence terms.
	self hasInterpretationArgument
		ifFalse:
			[arguments size = 1
				ifTrue: [associations := Array with: #resultTerm -> arguments first]
				ifFalse: [self error: 'incorrect amount of arguments']]
		ifTrue:
			[arguments size = 2
				ifTrue:
					[associations := Array
						with: #resultTerm -> arguments first
						with: #interpretationTerm -> (arguments at: 2)]
				ifFalse: [self error: 'incorrect amount of arguments']].
	^associations
]

{ #category : #private }
TemplateQueryTerm >> conversionQueryStringForParseTree: parsetreerepresentation [
	"Er wordt verwacht dat het resultaat van de template-resolutie ?result unificeert met ?resultTerm. Deze resolutie zal resultaten uit de Eclipse workspace ophalen, tenzij ?result al gebonden was aan ?resultTerm voor de resolutie begon. Om performantieoverwegingen wordt de conditie ?result equals: ?resultTerm daarom vooraan de gegenereerde query geplakt. Op methods en statements  zijn namelijk geen unificaties gedefinieerd die ervoor zouden kunnen zorgen dat er andere bindingen in de Eclipse workspace gevonden kunnen worden voor ?result die unificeren met ?resultTerm, maar er niet gelijk aan zijn. Op Eclipse expressions is dit wel gebeurd.

Concreet is het performantieverschil merkbaar bij de volgende query:
?s isStatement,
jtStatement(?s){return ?e;}
"

	
	| conversionQueryString functorName toBeLookedUpEvenIfGround |
	functorName := self type functor name.
	toBeLookedUpEvenIfGround := #(#jtExpression #jtClassDeclaration #jtInterfaceDeclaration #jtMethodDeclaration).
	conversionQueryString := 'if ' , parsetreerepresentation asString ,
			' templateUnderInterpretation: ?interpretationFooBar123 compilesTo: ?tempquery forResult: ?resultFooBar123 : ?annotation '.
	conversionQueryString := conversionQueryString
		,
			((toBeLookedUpEvenIfGround includes: functorName)
				ifTrue:
					[', append('
						,
							(self hasInterpretationArgument
								ifTrue:
									['<?interpretationFooBar123 equals: ?interpretationTerm | ?tempquery>']
								ifFalse: ['?tempquery']) ,
							', <?resultFooBar123 equals: ?resultTerm>, ?query)']
				ifFalse:
					[', ?query equals: <'
						,
							(self hasInterpretationArgument
								ifTrue: ['?interpretationFooBar123 equals: ?interpretationTerm,']
								ifFalse: ['']) ,
							' ?resultFooBar123 equals: ?resultTerm | ?tempquery>']).
	^conversionQueryString
]

{ #category : #private }
TemplateQueryTerm >> hasInterpretationArgument [
	
	^self type termSequence terms size = 2
]

{ #category : #private }
TemplateQueryTerm >> parse [
	"Delay parsing, if necessary, to after the loading of the entire repository"

	"Soul.Factory doAfterRepositoryLoad: [self setParseTree]."

	
	parsetrees := self asParseTrees.
	queries := self asQueries.
	^super parse
]

{ #category : #accessing }
TemplateQueryTerm >> parsetrees [
	
	^parsetrees
]

{ #category : #printing }
TemplateQueryTerm >> prettyPrintOn: aStream scope: id [
	
	type prettyPrintOn: aStream scope: id.
	super prettyPrintOn: aStream scope: id
]

{ #category : #printing }
TemplateQueryTerm >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' source: '.
	source printOn: aStream.
	aStream write: ' type: '.
	type printOn: aStream
]

{ #category : #printing }
TemplateQueryTerm >> printOn: aStream [
	
	type printOn: aStream.
	super printOn: aStream
]

{ #category : #accessing }
TemplateQueryTerm >> queries [
	
	^queries
]

{ #category : #private }
TemplateQueryTerm >> recursiveDefinitionRepository: aRepository [
	
	self definitionRepository: aRepository.
	self queries
		do:
			[:aQuery | aQuery do: [:i | i recursiveDefinitionRepository: aRepository]]
]

{ #category : #resolving }
TemplateQueryTerm >> resolveIn: anEnv startAt: anIndex [
	
	| resolveBlock |
	resolveBlock := [:aQuery | 
	ResolutionResult
		condition: (aQuery at: 1)
		rollbackInfo: anEnv rollbackInfo
		conditionsEnvIndex: anIndex
		cutState: false].
	^NativeResolver
		onBlock: resolveBlock
		withArguments: self queries
]

{ #category : #reification }
TemplateQueryTerm >> soulDownIn: anEnv startAt: anIndex [
	"DownedQuotedCode represents the QuotedCode construct on the  
	smalltalk-level. We also down our contents to allow an up later on"

	
	| string newcontent newvariables newparsetrees newqueries |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el soulDownIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | (el soulDownIn: anEnv startAt: anIndex) soulUp].
	newparsetrees := parsetrees
		collect: [:tree | (tree soulDownIn: anEnv startAt: anIndex) soulUp].
	newqueries := queries
		collect:
			[:tree | 
			Array
				with: ((tree at: 1) transitiveLookupIn: anEnv startAt: anIndex) soulUp
				with: (tree at: 2)].
	^DownedTemplateQuery fromString: string variables: newvariables content:
			newcontent block: block parsetrees: newparsetrees queries: newqueries
		type: type
]

{ #category : #initialize }
TemplateQueryTerm >> source: aString variables: aVarCollection content: aContent block: aBlock parsetrees: aParsetree queries: aQueries type: aType [
	
	self source: aString variables: aVarCollection content: aContent block:
			aBlock.
	parsetrees := aParsetree.
	queries := aQueries.
	type := aType
]

{ #category : #reification }
TemplateQueryTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	
	| string newvariables newcontent newparsetrees newqueries |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el transitiveLookupIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | el transitiveLookupIn: anEnv startAt: anIndex].
	newparsetrees := parsetrees
		collect:
			[:tree | (tree transitiveLookupIn: anEnv startAt: anIndex) soulUp].
	newqueries := queries
		collect:
			[:tree | 
			Array
				with: ((tree at: 1) transitiveLookupIn: anEnv startAt: anIndex) soulUp
				with: (tree at: 2)].
	^SoulFactory current makeTemplateQuery source: string variables: newvariables
		content: newcontent block: block parsetrees: newparsetrees queries:
			newqueries type: type
]

{ #category : #accessing }
TemplateQueryTerm >> type [
	"The type of the quotedcode"

	
	^type
]

{ #category : #accessing }
TemplateQueryTerm >> type: aType [
	"initalize the type of the quotedcode"

	
	type := aType
]
