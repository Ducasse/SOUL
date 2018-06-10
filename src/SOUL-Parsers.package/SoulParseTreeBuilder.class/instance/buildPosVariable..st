building SOUL
buildPosVariable: anIdentifierString
	
	^SoulFactory current makePosVariable name: (anIdentifierString allButFirst: 2)