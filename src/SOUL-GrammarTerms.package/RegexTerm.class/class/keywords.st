private
keywords
	
	keywords
		ifNil:
			[keywords := Dictionary new.
			keywords at: #manyOf put: #processManyOf:remainingConditions:.
			keywords at: #or put: #processOr:remainingConditions:.	"keywords at: #not put: #processNot:remainingConditions: ."
	"keywords at: #and put: #processAnd:remainingConditions: ."

			keywords at: #notSoManyOf put: #processLazyManyOf:remainingConditions:.
			keywords at: #plus put: #processPlus].
	^keywords