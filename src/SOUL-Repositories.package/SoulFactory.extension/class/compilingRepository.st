*SOUL-Repositories
compilingRepository
	
	| rep |
	^Repositories
		at: #compiling 
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			rep loadLayer: QuotedParseLayer.
			QuotedParseLayer allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: LogicPrimitives.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			self repository: #compiling put: rep.
			rep]