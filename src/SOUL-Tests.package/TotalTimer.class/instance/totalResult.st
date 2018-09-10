Public
totalResult
	
	^self totalsForClasses values
		inject: 0
		into: [:subTotal :number | subTotal + number]