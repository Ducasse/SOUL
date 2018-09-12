*LiCoR-Core
liCorRepository
	
	^ Repositories 
		at: #licor
		ifAbsentPut: [
			| rep |
			rep := SoulFactory current makeRepository new.
			rep loadLayer: SmalltalkReasoning.
			rep loadLayer: SmalltalkTemplateRuntimeLayer.
			SmalltalkReasoning allSubclasses do: [ :cl | rep loadLayer: cl ].
			LogicPrimitives allSubclasses do: [ :cl | rep loadLayer: cl ].
			SmalltalkReasoning allSubclasses do: [ :cl | rep loadLayer: cl ].
			rep ]