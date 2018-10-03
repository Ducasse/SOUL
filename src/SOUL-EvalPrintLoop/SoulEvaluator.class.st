Class {
	#name : #SoulEvaluator,
	#superclass : #Object,
	#instVars : [
		'ruleselector',
		'query',
		'allResults',
		'lastResultCollection',
		'lastTime'
	],
	#category : 'SOUL-EvalPrintLoop'
}

{ #category : #configuration }
SoulEvaluator class >> associatedFactory [
	
	^StandardSoulFactory
]

{ #category : #configuration }
SoulEvaluator class >> canBeConfigured [
	
	^false
]

{ #category : #configuration }
SoulEvaluator class >> configureFactory [
	
	^self associatedFactory install
]

{ #category : #'signal constants' }
SoulEvaluator class >> errorSignal [
	
	^SoulParseError
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText [
	"Evaluate the query in the default repository when none was specified."

	
	^self
		eval: aQueryText
		in: SoulFactory logicRepository
		withAssociations: #()
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository [
	
	^self eval: aQueryText in: aRepository withAssociations: #() notifying:
			nil
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository notifying: aTextController [
	
	^self eval: aQueryText in: aRepository withAssociations: #() notifying:
			aTextController
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository withAssociations: aCollection [
	
	^self eval: aQueryText in: aRepository withAssociations: aCollection
		notifying: nil
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository withAssociations: aCollection notifying: aTextController [
	
	| parser query |
	self configureFactory.
	parser := SoulFactory current makeParser.
	aTextController isNil
		ifTrue:
			[query := parser
				parse: aQueryText
				onError:
					[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]]
		ifFalse:
			[query := parser
				parse: aQueryText
				onError:
					[:text :pos | 
					aTextController
						insertAndSelect: '<-' , text
						at: pos.
					aTextController activate.
					^EmptyEvaluator new]].
	query species == SoulFactory current makeQuery
		ifFalse:
			[Error
				raiseSignal:
					'Evaluator input is not a query (missing ''if'' ?): ' , aQueryText].
	^self evalQuery: query in: aRepository withAssociations: aCollection
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository withAssociations: aCollection reportingProgressFor: aLabelText [
	
	^self eval: aQueryText in: aRepository withAssociations: aCollection
		reportingProgressFor: aLabelText notifying: nil
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText in: aRepository withAssociations: aCollection reportingProgressFor: aLabelText notifying: aTextController [
	
	| sel parser query newQueryText |
	(aCollection isEmpty
		or: [(aCollection first value isKindOf: Collection) not])
		ifTrue:
			[^self eval: aQueryText in: aRepository withAssociations: aCollection
				notifying: aTextController].
	sel := SoulFactory current makeRuleSelector new.
	parser := SoulFactory current makeParser.
	newQueryText := 'if [?counter value: ?counter value + 1. ?model value: ?counter value / '
		, aCollection first value size asString ,
			'. (?model value = 1) ifTrue:[?controller closeAndUnschedule]. true],'
		, (aQueryText allButFirst: 3).
	aTextController isNil
		ifTrue:
			[query := parser
				parse: newQueryText
				onError:
					[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString]]
		ifFalse:
			[query := parser
				parse: newQueryText
				onError:
					[:text :pos | 
					aTextController
						insertAndSelect: '<-' , text
						at: pos.
					aTextController activate.
					^EmptyEvaluator new]].
	query species == SoulFactory current makeQuery
		ifFalse:
			[Error
				raiseSignal:
					'Evaluator input is not a query (missing ''if'' ?): ' , aQueryText].
	query addConditionsInFront: (self makeEquals: aCollection).
	query
		addConditionsInFront:
			(parser
				parse:
					'if equals(?counter,[0 asValue]),equals(?model,[model := 0.0 asValue]),equals(?controller,[
			    ProgressWidgetView progressOpenOn: ?model
				label: ' , aLabelText printString , ' asText allBold])') condition
				terms.
	query definitionRepository: aRepository.
	self prepareDefinitionRepositoryOfQuery: query.
	sel evalQuery: query.
	^(self new)
		ruleselector: sel;
		query: query
]

{ #category : #'instance creation' }
SoulEvaluator class >> eval: aQueryText withAssociations: aCollection [
	"Evaluate the query in the default repository when none was specified."

	
	^self
		eval: aQueryText
		in: SoulFactory logicRepository
		withAssociations: aCollection
]

{ #category : #'instance creation' }
SoulEvaluator class >> evalQuery: query in: repository [
	
	| selector |
	query definitionRepository: repository.
	selector := (SoulFactory current makeRuleSelector new)
		evalQuery: query;
		yourself.
	^(self new)
		ruleselector: selector;
		query: query
]

{ #category : #'instance creation' }
SoulEvaluator class >> evalQuery: aQuery in: aRepository withAssociations: aCollection [
	
	| sel |
	self configureFactory.
	sel := SoulFactory current makeRuleSelector new.
	aQuery addConditionsInFront: (self makeEquals: aCollection).
	aQuery definitionRepository: aRepository.
	self prepareDefinitionRepositoryOfQuery: aQuery.
	sel evalQuery: aQuery.
	^(self new)
		ruleselector: sel;
		query: aQuery
]

{ #category : #private }
SoulEvaluator class >> makeEquals: aCollection [
	
	| result var val terms equals |
	result := OrderedCollection new.
	aCollection
		do:
			[:varvalue | 
			| functorname |
			var := SoulFactory current makeVariable name: varvalue key asString.	"WARNING: the implementation of this method changed to invoke the parser because a bug occurred when the values are soul terms extracted from other terms. Since these will again be passing through the variable indexer and break the entire variable-indexing mechanism. Passing everything through the parser ensures making a unique copy that can be cleaned on its own"

			((varvalue value isKindOf: AbstractTerm)
				and: [(varvalue value isKindOf: UppedObject) not])
				ifTrue:
					[| copying "[val := (SoulParser parse: varvalue value displayString) terms first
						conclusion]"
 |
					copying := CopyingVisitor new.
					val := varvalue value accept: copying]
				ifFalse: [val := varvalue value soulUp].
			functorname := (varvalue value isMemberOf: OrderedCollection)
				ifTrue: [#member]
				ifFalse: [#equals].
			terms := OrderedCollection new.
			terms add: var.
			terms add: val.
			equals := SoulFactory current makeCompound
				functor: (Constant name: functorname)
				termSequence: (TermSequence terms: terms).
			result add: equals].
	^result
]

{ #category : #private }
SoulEvaluator class >> prepareDefinitionRepositoryOfQuery: aQuery [
	
	aQuery definitionRepository
		additionalClausesToBeAdded:
			aQuery additionalClausesForDefinitionRepository.
	aQuery definitionRepository compile
]

{ #category : #evaluation }
SoulEvaluator >> allResults [
	
	allResults
		timeTaken:
			(lastTime := Time
				millisecondsToRun:
					[[(lastResultCollection := ruleselector next) == false]
						whileFalse: [allResults add: lastResultCollection].
					allResults isEmpty ifTrue: [allResults add: lastResultCollection]])
				+ allResults timeTaken.
	^allResults
]

{ #category : #private }
SoulEvaluator >> lastResult [
	
	| results |
	results := SoulFactory current makeResults onQuery: query.
	results add: lastResultCollection.
	^results
]

{ #category : #evaluation }
SoulEvaluator >> nextResult [
	
	| result |
	result := SoulFactory current makeResults onQuery: query.
	result
		timeTaken:
			(Time millisecondsToRun: [lastResultCollection := ruleselector next]).
	result add: lastResultCollection.
	allResults add: lastResultCollection.
	allResults timeTaken: result timeTaken + allResults timeTaken.
	^result
]

{ #category : #private }
SoulEvaluator >> query [
	
	^query
]

{ #category : #initialize }
SoulEvaluator >> query: aQuery [
	
	query := aQuery.
	allResults := SoulFactory current makeResults onQuery: query
]

{ #category : #evaluation }
SoulEvaluator >> results [
	
	^allResults
]

{ #category : #private }
SoulEvaluator >> ruleselector [
	
	^ruleselector
]

{ #category : #initialize }
SoulEvaluator >> ruleselector: sel [
	
	ruleselector := sel 
]
