SLG
slg: aCallTerm
	
	| theCall |
	theCall := self callForCallTerm: aCallTerm.
	theCall comp
		ifFalse:
			[theCall evaluate.
			self completeCallTerm: theCall].
	^theCall answersShowMuffled: true