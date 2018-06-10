accessing
addNegativeWaitingId: anId variables: someVars delay: delay continuation: continuationPredicate
	"Add a negative waiting node"

	
	| positiveDelayed negativeDelayed |
	positiveDelayed := delay at: 1.
	negativeDelayed := delay at: 2.
	negativeWaitingNodes
		add:
			(WaitingNode callId: anId variables: someVars delayedPrimitives:
					positiveDelayed delayedNegatedPrimitives: negativeDelayed
				continuation: continuationPredicate)