evaluation
evaluateNegativeWaitingNode: aWaitingNode
	"boolean indicates undefined"

	
	| id continuation waitingevaluator vars associations newDelayed onlyDelayedAnswers hasNoAnswer |
	onlyDelayedAnswers := (answers
		contains:
			[:answer | 
			| delayed pos neg |
			delayed := answer at: 2.
			pos := delayed at: 1.
			neg := delayed at: 2.
			pos isEmpty and: [neg isEmpty]]) not.
	hasNoAnswer := answers isEmpty or: [onlyDelayedAnswers].
	hasNoAnswer
		ifTrue:
			[id := aWaitingNode callId.
			continuation := aWaitingNode continuation.
			vars := aWaitingNode variables.
			newDelayed := aWaitingNode delayedNegatedPrimitives.
			(answers isEmpty not and: [onlyDelayedAnswers])
				ifTrue:
					[newDelayed
						detect: [:x | x = self]
						ifNone: [newDelayed add: self]].
			associations := OrderedCollection
				with:
					#Delayed
						->
							(Array
								with: aWaitingNode delayedPrimitives
								with: newDelayed)
				with: #Cont -> continuation
				with: #Id -> id
				with: #Vars -> vars.
			waitingevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: (self prepareQuery: negativeQuery)
				in: callTerm definitionRepository
				withAssociations: associations.
			waitingevaluator allResults]