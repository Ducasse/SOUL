Examples
fullyTimeSuite
	"Fully time me, and output the results on the default stream."

	
	| theTimer |
	theTimer := TotalTimer new.
	self setLogicTimer: theTimer.
	self buildSuite run.
	theTimer outputClassResults.
	theTimer outputTotalResult