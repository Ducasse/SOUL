"
LogicRepository that does not do the automatic cleaning of clauses during recompilation.
"
Class {
	#name : #LogicRepositoryWithoutCleaning,
	#superclass : #LogicRepository,
	#category : #'SOUL-Repositories'
}

{ #category : #'prepare for use' }
LogicRepositoryWithoutCleaning >> compileForced: aBoolean [
	"Compile the clauses in this repository if the changed flag indicates that it is no longer in sync with the storage"

	
	| time |
	(aBoolean
		or: [storageChanged or: [(compilationFactory = SoulFactory current) not]])
		ifTrue:
			[time := Time
				millisecondsToRun:
					[self addLayers.
					self addClauses: additionalClauses.	"self createCallGraph."

					self transformTabledRules.
					self createLexicalAddresses.
					storageChanged := false.
					compilationFactory := SoulFactory current].
			Transcript
				show: 'Recompiled repository in ' , time asString , ' ms.';
				cr]
]
