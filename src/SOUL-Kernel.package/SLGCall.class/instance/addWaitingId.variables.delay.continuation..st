accessing
addWaitingId: anId variables: someVars delay: delay continuation: continuationPredicate
	"Add a waiting node"

	
	| positiveDelayed negativeDelayed |
	positiveDelayed := delay at: 1.
	negativeDelayed := delay at: 2.
	waitingNodes
		add:
			(WaitingNode callId: anId variables: someVars delayedPrimitives:
					positiveDelayed delayedNegatedPrimitives: negativeDelayed
				continuation: continuationPredicate)