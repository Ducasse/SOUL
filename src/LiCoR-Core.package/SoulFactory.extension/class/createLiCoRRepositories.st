*LiCoR-Core
createLiCoRRepositories
	
	| rep |
	rep := SoulFactory current makeRepository new.
	rep loadLayer: SmalltalkReasoning.
	rep loadLayer: SmalltalkTemplateRuntimeLayer.
	SmalltalkReasoning allSubclasses do: [:cl | rep loadLayer: cl].
	LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
	SoulFactory repository: #'LiCoR-Smalltalk' put: rep.
	rep := (SoulFactory repository: #test) loadLayer: SmalltalkReasoning.
	SmalltalkReasoning allSubclasses do: [:cl | rep loadLayer: cl]