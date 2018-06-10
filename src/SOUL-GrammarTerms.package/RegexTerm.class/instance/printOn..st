printing
printOn: aStream
	goals printAsKeywordArgOn: aStream.
	aStream write: ' matches: graph('.
	(self getEdgeTerm) printOn: aStream.
	aStream write: ', '.
	(self getStartWorld) printOn: aStream.
	aStream write: ', '.
	(self getEndWorld) printOn: aStream.
	aStream write: ', '.
	(self getVariables) printOn: aStream.
	aStream write: ', '.
	(self getPathVariable) printOn: aStream.
	aStream write: ')'