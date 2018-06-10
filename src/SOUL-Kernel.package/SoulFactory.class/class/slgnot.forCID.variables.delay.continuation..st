SLG
slgnot: aCallTerm forCID: anInteger variables: vars delay: delay continuation: cont
	
	| call otherCall |
	call := self callForCallTerm: aCallTerm.
	otherCall := CallsPerCID at: anInteger.
	call isNew
		ifTrue:
			[call addNegativeWaitingId: anInteger variables: vars delay: delay
				continuation: cont.
			call evaluate.
			self completeCallTerm: call.
			call comp
				ifFalse:
					[call hasMaxNLink
						ifFalse: [otherCall setMinNLink: (call nlink min: call plink)]
						ifTrue: [otherCall setMinNLink: call plink]]]
		ifFalse:
			[call answers isEmpty
				ifTrue:
					["call does not have an answer without delayed vars"

					call comp
						ifFalse:
							[call addNegativeWaitingId: anInteger variables: vars delay: delay
								continuation: cont.	"call evaluateAnswersWith: cont id: anInteger vars: vars delay: delay."

							call hasMaxNLink
								ifFalse: [otherCall setMinNLink: (call nlink min: call plink)]
								ifTrue: [otherCall setMinNLink: call plink]]
						ifTrue:
							[call
								evaluateNegativeWaitingNode:
									(WaitingNode
										callId: anInteger
										variables: vars
										delayedPrimitives: (delay at: 1) copy
										delayedNegatedPrimitives: (delay at: 2) copy
										continuation: cont)]]]