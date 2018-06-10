SLG - auxiliary
completeCallTerm: aCallTerm
	
	| poppedTerms copiedTerms positive negative justBelow |
	aCallTerm isCompletelyEvaluated
		ifTrue:
			[poppedTerms := self popUntilCallTerm: aCallTerm.
			poppedTerms asSet
				do:
					[:aTerm | 
					aTerm comp: true.
					self simplifyDependencyCallsFor: aTerm.
					aTerm removeWaitingNodes.
					aTerm evaluateNegativeWaitingNodes: false deleteNodes: true].
			^self].
	aCallTerm dependsOnCallDeepBelow
		ifTrue:
			[copiedTerms := self copyUntilCallTerm: aCallTerm.
			copiedTerms
				do:
					[:aTerm | 
					aTerm nlinkToMax.	"return undefined to negative waiting nodes"

					aTerm evaluateNegativeWaitingNodes: true deleteNodes: false].
			positive := Float infinity.
			negative := Float infinity.
			copiedTerms reverse
				do:
					[:aTerm | 
					aTerm plink == Float infinity
						ifFalse: [positive := positive min: aTerm plink].
					aTerm nlink == Float infinity
						ifFalse: [negative := negative min: aTerm nlink].
					aTerm plink: positive.
					aTerm nlink: negative.
					self completeCallTerm: aTerm].
			^self].
	justBelow := self justBelowTerm: aCallTerm.
	justBelow setMinPLink: aCallTerm plink.
	justBelow setMinNLink: aCallTerm nlink.
	^self