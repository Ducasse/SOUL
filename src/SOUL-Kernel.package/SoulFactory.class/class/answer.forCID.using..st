SLG
answer: aHead forCID: anInteger using: delayed
	
	| call positiveDelayed negativeDelayed |
	positiveDelayed := delayed at: 1.
	negativeDelayed := delayed at: 2.
	call := CallsPerCID at: anInteger.
	(call includesAnswer: aHead using: delayed)
		ifFalse:
			[call addAnswer: aHead with: delayed.
			positiveDelayed
				do: [:aTerm | self addDependentCall: aTerm dependentOf: call].
			negativeDelayed
				do: [:aTerm | self addNegatedDependentCall: aTerm dependentOf: call].
			call evaluateWaitingNodesWithAnswer: aHead using: delayed]