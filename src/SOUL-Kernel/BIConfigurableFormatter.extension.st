Extension { #name : #BIConfigurableFormatter }

{ #category : #'*SOUL-Kernel' }
BIConfigurableFormatter >> visitDelayedSoulVariable: aSoulVariable [
	
	codeStream
		nextPutAll:
			(SoulFactory current makeDelayedVariable name: aSoulVariable name)
				smalltalkBlockString
]

{ #category : #'*SOUL-Kernel' }
BIConfigurableFormatter >> visitSoulVariable: aSoulVariable [
	
	codeStream
		nextPutAll:
			(SoulFactory current makeVariable name: aSoulVariable name)
				smalltalkBlockString
]
