parsing
addTermFirst: aTerm
	"used by the parser"

	
	(aTerm isKindOf: Cut) ifTrue: [containsCut := true].
	self terms addFirst: aTerm