configuration
isSelectorTimed
	"this setting determines whether the user specific timings are executed 
	and  
	shown (see the methods #startWatch and #stopAndShowWatch). If true,  
	these results are displayed on the Transcript. By default this is false (so 
	it runs as plain tests, without timing). Set this true to allow course  
	grained benchmarking."

	
	IsSelectorTimed isNil ifTrue: [IsSelectorTimed := false].
	^IsSelectorTimed