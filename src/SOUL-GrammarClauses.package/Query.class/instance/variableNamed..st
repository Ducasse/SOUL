access
variableNamed: aString
	
	^self variables
		detect: [:each | each name = aString]
		ifNone:
			[self
				error:
					'Variable ''?' , aString , ''' not found in query: ''' , self printString ,
							'''']