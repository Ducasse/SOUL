SLG - auxiliary
newSLGCallFor: aLogicTerm inCollection: aCollection
	
	| theCall |
	theCall := SLGCall
		call: aLogicTerm
		cid: self uniqueCallId.
	aCollection add: theCall.
	CallsPerCID
		at: theCall cid
		put: theCall.
	^theCall