Extension { #name : #Stream }

{ #category : #'*SOUL-Kernel' }
Stream >> write: encodedObject [
	
	^encodedObject putOn: self
]
