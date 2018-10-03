Extension { #name : #Collection }

{ #category : #'*SOUL-Kernel' }
Collection >> write: anObject [
	
	self add: anObject.
	^anObject
]
