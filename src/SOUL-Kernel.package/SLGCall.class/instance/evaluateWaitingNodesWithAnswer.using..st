evaluation
evaluateWaitingNodesWithAnswer: aTerm using: delayed
	
	| id continuation waitingevaluator vars associations newDelayed positive negative hasNoDelayed query |
	positive := delayed at: 1.
	negative := delayed at: 2.
	hasNoDelayed := positive isEmpty and: [negative isEmpty].
	hasNoDelayed
		ifTrue:
			["we have a real answer without waitingnodes. Any negative waiting node must fail"

			negativeWaitingNodes := OrderedCollection new].
	waitingNodes
		do:
			[:aWaitingNode | 
			id := aWaitingNode callId.
			continuation := aWaitingNode continuation.
			vars := aWaitingNode variables.
			newDelayed := aWaitingNode delayedPrimitives.
			hasNoDelayed ifFalse: [newDelayed add: aTerm].
			associations := OrderedCollection
				with:
					#Delayed
						->
							(Array
								with: newDelayed
								with: aWaitingNode delayedNegatedPrimitives)
				with: #Cont -> continuation
				with: #Vars -> vars
				with: #Answer -> aTerm.
			associations add: #Id -> id.	"waitingevaluator := Soul.Evaluator
			eval: ('if ' , (continuation asString, '(' , id asString , ',', vars asString, ',', aTerm asString ,', ?D', ')' )) asString
			in: callTerm definitionRepository
			withAssociations: associations."

			query := continuationQuery accept: CopyingVisitor new.
			waitingevaluator := SoulFactory current evaluatorForLogicQuery
				evalQuery: query
				in: callTerm definitionRepository
				withAssociations: associations.
			waitingevaluator allResults]