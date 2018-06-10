instance creation
eval: aQueryText withAssociations: aCollection
	"Evaluate the query in the default repository when none was specified."

	
	^self
		eval: aQueryText
		in: SoulFactory logicRepository
		withAssociations: aCollection