accessing
setMinPLink: anInteger
	
	anInteger == Float infinity ifFalse: [plink := plink min: anInteger].
	^plink