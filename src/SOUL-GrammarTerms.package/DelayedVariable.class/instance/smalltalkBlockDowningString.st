converting
smalltalkBlockDowningString
	"see comment in Variable"

	
	^'(env transitiveLookup: arg' , self name , ' startAt: envIndex)'