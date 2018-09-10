Examples
fullyTimeSuiteOnStream: aStream
	"Fully time me, and output the results on the given stream."

	
	| theTimer |
	theTimer := TotalTimer new.
	theTimer outputStream: aStream.
	self setLogicTimer: theTimer.
	self buildSuite run.
	theTimer outputClassResults.
	theTimer outputTotalResult