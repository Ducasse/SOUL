evaluation
evaluateAnswersWith: aContinuation id: anId vars: vars delay: delay
	
	| answerevaluator delayed associations positive negative |
	"Evaluate the answers with a waitingNode"

	positive := delay at: 1.
	negative := delay at: 2.
	delayed := positive copy.
	answers copy
		do:
			[:anAnswer | 
			(positive isEmpty and: [negative isEmpty])
				ifFalse: [delayed add: (anAnswer at: 1)].
			associations := OrderedCollection
				with: #Delayed -> (Array with: delayed with: negative)
				with: #Cont -> aContinuation
				with: #Vars -> vars
				with: #Answer -> (anAnswer at: 1).
			associations add: #Id -> anId.
			answerevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: (self prepareQuery: continuationQuery)
				in: callTerm definitionRepository
				withAssociations: associations.
			answerevaluator allResults]