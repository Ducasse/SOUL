*SOUL-Repositories
logicRepository
	
	| rep |
	rep := Repositories
		at: #logic
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."

			rep].	"TO BE REMOVED IN LATER VERSIONS!"

	Repositories at: #default put: rep.
	^rep