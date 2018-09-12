*SOUL-Kernel
reifiedSoulChildren
	
	(self hasProperty: #reifiedSoulChildren)
		ifFalse: [ self propertyAt: #reifiedSoulChildren put: (self soulChildren collect: #soulUp) ].
	
	^ self propertyAt: #reifiedSoulChildren ifAbsent:[ #() ]