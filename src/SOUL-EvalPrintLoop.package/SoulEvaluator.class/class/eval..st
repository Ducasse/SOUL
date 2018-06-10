instance creation
eval: aQueryText
	"Evaluate the query in the default repository when none was specified."

	
	^self
		eval: aQueryText
		in: SoulFactory logicRepository
		withAssociations: #()