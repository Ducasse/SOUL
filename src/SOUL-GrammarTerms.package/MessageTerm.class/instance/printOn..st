printing
printOn: aStream
	"UGLY: should really be replaced with nice double dispatching"

	"No... really?"

	
	self isKeyworded ifTrue: [^self printKeywordStyleOn: aStream].
	self isKeywordedMessage
		ifTrue: [^self printKeywordMessageStyleOn: aStream].
	self isUnaryMessage ifTrue: [^self printUnaryMessageStyleOn: aStream].
	self halt: 'terribly wrong'