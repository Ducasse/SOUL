building SOUL
buildDelayedVariable: anIdentifierString
	
	^SoulFactory current makeDelayedVariable
		name: (anIdentifierString allButFirst: 1)