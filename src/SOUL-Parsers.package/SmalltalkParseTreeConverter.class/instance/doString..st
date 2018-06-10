public access
doString: aString
	
	^self startForNode: (RBParser parseMethod: aString)