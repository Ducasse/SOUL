Extension { #name : #SequenceableCollection }

{ #category : #'*SOUL-Kernel' }
SequenceableCollection >> findFirst: aBlock startingAt: anIndex [
	"Taken from TreeModel"

	
	anIndex
		to: self size
		do: [:index | (aBlock value: (self at: index)) ifTrue: [^index]].
	^0
]

{ #category : #'*SOUL-Kernel' }
SequenceableCollection >> speciesAppend: aSequnceableCollection [
	"Answer a copy of the receiver concatenated with the 
	argument, a SequenceableCollection."

	"Roel: The regular #, does not take the type of the receiver into 
	account. For example, appending symbols results in a String."

	"The default implementation falls back on #,. Subclasses that 
	have problems (such as Symbol) can override this to return the 
	correct type."

	
	^self , aSequnceableCollection
]

{ #category : #'*SOUL-Kernel' }
SequenceableCollection >> speciesCopyFrom: startIndex to: stopIndex [
	"Roel: The regular #copyFrom:to: does not take the type of the 
	receiver into account. For example, copying a part from a 
	symbol results in a String."

	"The default implementation falls back on #copyFrom:to:. 
	Subclasses that have problems (such as Symbol) can override 
	this to return the correct type."

	
	^self copyFrom: startIndex to: stopIndex
]

{ #category : #'*SOUL-Kernel' }
SequenceableCollection >> with: aSequenceableCollection do: aBlock separatedBy: separatorBlock [
	"Evaluate aBlock with each of the receiver's elements along with the corresponding
	element from aSequencableCollection."

	
	| otherCollection |
	self size ~= aSequenceableCollection size ifTrue: [^self noMatchError].
	otherCollection := ReadStream on: aSequenceableCollection.
	self
		do:
			[:each | 
			aBlock
				value: each
				value: otherCollection next]
		separatedBy: separatorBlock
]
