converting
asPrologIn: env startAt: idx
	
	| stream |
	stream := WriteStream on: String new.
	self printAsPrologOn: stream scope: #asClause in: env startAt: env.
	^stream contents