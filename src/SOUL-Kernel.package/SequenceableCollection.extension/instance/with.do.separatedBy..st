*SOUL-Kernel
with: aSequenceableCollection do: aBlock separatedBy: separatorBlock
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