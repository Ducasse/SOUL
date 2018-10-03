Class {
	#name : #SoulReflectionTest,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #repositories }
SoulReflectionTest >> testexistsInRepository [
	"self run:#testexistsInRepository"

	"existsInRepository/1"

	
	self processQuery:
			' if succeeds(existsInRepository(fact2(onlyOccurence)))' description:
			'Can we find a clause in the repository of which the head unifies with fact2(onlyOccurence)'.
	self processQuery: ' if fails(existsInRepository(fact2(zork)))'
		description:
			'Cannot we find a clause in the repository of which the head unifies with fact2(zork)'.
	self processQuery: ' if succeeds(existsInRepository(fact2(?)))'
		description:
			'Can we find a clause in the repository of which the head unifies with fact2(?)'.
	self
		processQuery: ' if existsInRepository(fact1(?x))'
		resultsCheck: [:results | results size = 1]
		description:
			'If there is more than one matching clause in the repository, do we get only one result?'
]
