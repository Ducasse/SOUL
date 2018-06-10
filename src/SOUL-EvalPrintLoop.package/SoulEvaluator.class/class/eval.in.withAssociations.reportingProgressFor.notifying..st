instance creation
eval: aQueryText in: aRepository withAssociations: aCollection reportingProgressFor: aLabelText notifying: aTextController
	
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