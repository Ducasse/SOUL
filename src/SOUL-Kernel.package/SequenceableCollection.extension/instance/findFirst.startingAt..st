*SOUL-Kernel
findFirst: aBlock startingAt: anIndex
	"Taken from TreeModel"

	
	anIndex
		to: self size
		do: [:index | (aBlock value: (self at: index)) ifTrue: [^index]].
	^0