Examples
averageTotalOfRuns: number
	"Run me a certain times, and return the average time it took"

	"QSOULArithmeticTest averageTotalOfRuns: 3"

	
	| allTotals theTimer suite |
	allTotals := OrderedCollection new.
	theTimer := TotalTimer new.
	self setLogicTimer: theTimer.
	suite := self buildSuite.
	number
		timesRepeat:
			[suite run.
			allTotals add: theTimer totalResult.
			theTimer resetTimings].
	^(allTotals
		inject: 0
		into: [:subTotal :timing | subTotal + timing]) / number