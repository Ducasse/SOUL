public-access
variableNamed: aString
	
	^self variables
		detect: [:keyVar | keyVar name = aString]
		ifNone:
			[self
				error:
					'Variable ''?' , aString , ''' not found in query: '''
						, self query printString , '''']