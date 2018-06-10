printing
prettyPrintAsKeywordArgOn: aStream scope: id
	"UGLY: should change type test to double dispatching"

	
	self isMultiPart ifTrue: [aStream write: '('].
	self prettyPrintOn: aStream scope: id.
	self isMultiPart ifTrue: [aStream write: ')']