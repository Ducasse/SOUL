Class {
	#name : #ProgramSequence,
	#superclass : #TermSequence,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
ProgramSequence class >> clauses: aCollection [
	
	^self terms: aCollection
]

{ #category : #access }
ProgramSequence >> addAll: programSequence [
	
	collection addAll: programSequence clauses
]

{ #category : #repository }
ProgramSequence >> addToRepository: aRepository [
	
	self clauses do: [:c | c addToRepository: aRepository]
]

{ #category : #access }
ProgramSequence >> clauses [
	
	^collection
]

{ #category : #printing }
ProgramSequence >> printForCompileOn: aStream [
	
	aStream write: '^(' , self class name , ' terms: (OrderedCollection new '.
	collection
		do:
			[:currentClause | 
			aStream write: 'add:('.
			currentClause printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself))'
]

{ #category : #printing }
ProgramSequence >> printOn: aStream [
	
	collection
		do: [:currentClause | currentClause printOn: aStream]
		separatedBy:
			[aStream
				write: '.';
				cr]
]
