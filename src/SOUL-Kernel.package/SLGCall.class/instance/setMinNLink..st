accessing
setMinNLink: anInteger
	
	anInteger == Float infinity ifFalse: [nlink := nlink min: anInteger].
	^nlink