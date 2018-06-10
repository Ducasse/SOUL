*SOUL-Repositories
parsingRepository
	
	| rep |
	^Repositories
		at: #parsing
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			rep loadLayer: QuotedParseLayer.
			QuotedParseLayer allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: LogicPrimitives.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			self repository: #parsing put: rep.
			rep]