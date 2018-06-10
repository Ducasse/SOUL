delegation
doesNotUnderstand: aMessage
	
	^self degree > 0
		perform: aMessage selector
		withArguments: aMessage arguments