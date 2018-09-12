reification - entities
allMethodEntities
	"Returns a collection containing all the methods in the Smalltalk image. They are wrapped in our own SoulSmalltalkMethod class"

	
	| allMethods filteredMethods |
	allMethods := OrderedCollection new.
	CompiledMethod withAllSubclasses
		do: [:class | allMethods addAll: class allInstances].
	filteredMethods := allMethods
		select: [:m | m methodClass ~~ nil ].
	^filteredMethods
		collect: [:cm | self smalltalkMethodClass compiledMethod: cm]