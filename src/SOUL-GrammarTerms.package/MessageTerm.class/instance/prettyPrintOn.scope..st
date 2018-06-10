printing
prettyPrintOn: aStream scope: id
	"UGLY: should really be replaced with nice double dispatching"

	
	self isKeyworded
		ifTrue: [^self prettyPrintKeywordStyleOn: aStream scope: id].
	self isKeywordedMessage
		ifTrue: [^self prettyPrintKeywordMessageStyleOn: aStream scope: id].
	self isUnaryMessage
		ifTrue: [^self prettyPrintUnaryMessageStyleOn: aStream scope: id].
	self halt: 'terribly wrong'