printing
printAsKeywordArgOn: aStream
	"UGLY: should change type test to double dispatching"

	
	self isMultiPart ifTrue: [aStream write: '('].
	self printOn: aStream.
	self isMultiPart ifTrue: [aStream write: ')']