private
generateContinuationHead: anInteger
	
	^'cont' , anInteger asString , self predicate reject: [:x | x = $:]