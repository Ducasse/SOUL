*SOUL-Repositories
transparentSymbiosisRepository
	
	| rep |
	^Repositories
		at: #'transparant-symbiosis'
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			LogicStorage allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."

			rep]