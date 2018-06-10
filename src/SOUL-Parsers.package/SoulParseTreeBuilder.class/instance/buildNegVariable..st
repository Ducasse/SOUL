building SOUL
buildNegVariable: anIdentifierString
	
	^SoulFactory current makeNegVariable name: (anIdentifierString allButFirst: 2)