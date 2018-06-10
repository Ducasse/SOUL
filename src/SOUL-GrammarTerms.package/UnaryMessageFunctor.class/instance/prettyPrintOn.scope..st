printing
prettyPrintOn: aStream scope: id
	
	| temp attributes|
	attributes := OrderedCollection with:(TextColor black).
	id = #asClause
		ifTrue:
			[attributes add:TextEmphasis bold].
	aStream withAttributes: attributes do: [self printOn: aStream].
	