reification
soulDownIn: anEnv startAt: anIndex
	"the downed version of a SmallTalkTerm is the result of it's evaluation"

	
	^self evaluateIn: anEnv startAt: anIndex