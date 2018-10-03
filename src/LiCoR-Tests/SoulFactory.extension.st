Extension { #name : #SoulFactory }

{ #category : #'*LiCoR-Tests' }
SoulFactory class >> liCorTestRepository [
	
	
	^ Repositories 
		at: #licortest
		ifAbsentPut: [
			| rep |
			rep := SoulFactory current makeRepository new.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: TestQueriesLayer.
			TestQueriesLayer allSubclasses do: [:cl | rep loadLayer: cl].	
			SmalltalkReasoning allSubclasses do: [:cl | rep loadLayer: cl].
			rep ]
]
