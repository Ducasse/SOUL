instance creation
degree: aNumber
	
	aNumber = 0 ifTrue: [^false].
	aNumber = 1 ifTrue: [^true].
	^self new degree: aNumber