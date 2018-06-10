evaluation
allResults
	
	allResults
		timeTaken:
			(lastTime := Time
				millisecondsToRun:
					[[(lastResultCollection := ruleselector next) == false]
						whileFalse: [allResults add: lastResultCollection].
					allResults isEmpty ifTrue: [allResults add: lastResultCollection]])
				+ allResults timeTaken.
	^allResults