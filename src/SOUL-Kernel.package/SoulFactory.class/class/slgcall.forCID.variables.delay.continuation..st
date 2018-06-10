SLG
slgcall: aCallTerm forCID: anInteger variables: vars delay: delay continuation: cont
	
	| call otherCall |
	call := self callForCallTerm: aCallTerm.
	otherCall := CallsPerCID at: anInteger.
	call addWaitingId: anInteger variables: vars delay: delay continuation: cont.
	call isNew
		ifTrue:
			[call evaluate.
			self completeCallTerm: call.
			otherCall comp
				ifFalse:
					[otherCall setMinPLink: call plink.
					otherCall setMinNLink: call nlink]]
		ifFalse:
			[otherCall setMinPLink: call plink.
			otherCall setMinNLink: call nlink.
			call evaluateAnswersWith: cont id: anInteger vars: vars delay: delay]