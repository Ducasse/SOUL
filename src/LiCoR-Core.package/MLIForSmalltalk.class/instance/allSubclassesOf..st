classes
allSubclassesOf: aClass
	"return a stream with all subclasses for aClass (direct AND indirect  
	subclasses)"

	
	^aClass withAllSubclasses asOrderedCollection