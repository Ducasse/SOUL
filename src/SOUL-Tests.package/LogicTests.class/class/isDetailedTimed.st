configuration
isDetailedTimed
	"this setting determines whether individual tests are timed, and the  
	results displayed on the Transcript. By default this is false (so  
	it runs as plain tests, without timing). Set this to true to allow fine  
	grained benchmarking."

	
	IsDetailedTimed isNil ifTrue: [IsDetailedTimed := true].
	^IsDetailedTimed