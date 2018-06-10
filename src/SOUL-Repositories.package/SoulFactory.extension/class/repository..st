*SOUL-Repositories
repository: aName
	
	aName = #logic ifTrue: [self logicRepository].	"aName = #default ifTrue:[ 	self defaultRepository ]."

	aName = #parsing ifTrue: [self parsingRepository].
	^Repositories at: aName