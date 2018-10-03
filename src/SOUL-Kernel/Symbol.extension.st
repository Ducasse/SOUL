Extension { #name : #Symbol }

{ #category : #'*SOUL-Kernel' }
Symbol >> asSoulConstant [
	
	^SoulFactory current makeConstant name: self
]

{ #category : #'*SOUL-Kernel' }
Symbol >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	| fixedCopy |
	(self contains: [:c | c isLetter not]) | self first isUppercase
		ifTrue:
			[fixedCopy := (self copyReplaceAll: '\' with: '\\') copyReplaceAll: '"'
				with: '\"'.
			aStream nextPut: $'.
			aStream nextPutAll: fixedCopy.
			aStream nextPut: $']
		ifFalse: [aStream nextPutAll: self]
]

{ #category : #'*SOUL-Kernel' }
Symbol >> speciesAppend: aSequnceableCollection [
	"Answer a copy of the receiver concatenated with the 
	argument, a SequenceableCollection."

	"Roel: The regular #, does not take the type of the receiver into 
	account. For example, appending symbols results in a String."

	"The default implementation falls back on #,. Subclasses that 
	have problems (such as Symbol) can override this to return the 
	correct type."

	
	^(self , aSequnceableCollection) asSymbol
]

{ #category : #'*SOUL-Kernel' }
Symbol >> speciesCopyFrom: startIndex to: stopIndex [
	"Roel: The regular #copyFrom:to: does not take the type of the 
	receiver into account, so copying a part from a symbol results 
	in a String. This method makes sure that the result is a Symbol."

	
	^(self copyFrom: startIndex to: stopIndex) asSymbol
]
