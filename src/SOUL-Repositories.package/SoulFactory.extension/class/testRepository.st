*SOUL-Repositories
testRepository
	
	
	^ Repositories 
		at: #test
		ifAbsentPut: [
			| rep |
			rep := SoulFactory current makeRepository new.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: TestQueriesLayer.
			TestQueriesLayer allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."
			rep loadLayer: SmalltalkReasoning.
			SmalltalkReasoning allSubclasses do: [:cl | rep loadLayer: cl].
			rep ]