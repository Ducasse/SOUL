evaluation
evaluateNegativeWaitingNodes: aBoolean deleteNodes: anotherBoolean
	"aBoolean indicates undefined"

	
	| id continuation waitingevaluator vars associations newDelayed onlyDelayedAnswers hasNoAnswer negNodes |
	onlyDelayedAnswers := (answers
		noneSatisfy:
			[:answer | 
			| delayed pos neg |
			delayed := answer at: 2.
			pos := delayed at: 1.
			neg := delayed at: 2.
			pos isEmpty and: [neg isEmpty]]).
	hasNoAnswer := answers isEmpty or: [onlyDelayedAnswers].
	hasNoAnswer
		ifTrue:
			[negNodes := negativeWaitingNodes.
			anotherBoolean ifTrue: [negativeWaitingNodes := OrderedCollection new].
			negNodes
				do:
					[:aWaitingNode | 
					id := aWaitingNode callId.
					continuation := aWaitingNode continuation.
					vars := aWaitingNode variables.
					newDelayed := aWaitingNode delayedNegatedPrimitives.
					(aBoolean or: [answers isEmpty not and: [onlyDelayedAnswers]])
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
						evalQuery: (Query condition: negativeQuery condition copy)
						in: callTerm definitionRepository
						withAssociations: associations.
					waitingevaluator allResults]]
		ifFalse:
			["negativeWaitingNodes isEmpty ifFalse: [
			^self halt: 'nodes should have been removed when answer was computed'.
		]."

			negativeWaitingNodes := OrderedCollection new]