building SOUL
buildVariable: anIdentifierString
	
	^SoulFactory current makeVariable name: (anIdentifierString allButFirst: 1)