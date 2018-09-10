Private
addToCurrentCaseCount: number
	
	caseCount = 0
		ifTrue: [caseCount := number]
		ifFalse: [caseCount := caseCount + number]