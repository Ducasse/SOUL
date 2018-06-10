repositories
createAnonymousRepository
	
	| rep |
	rep := SoulFactory current makeRepository new loadLayer: self.
	self allSubclasses do: [:cl | rep loadLayer: cl].
	^rep