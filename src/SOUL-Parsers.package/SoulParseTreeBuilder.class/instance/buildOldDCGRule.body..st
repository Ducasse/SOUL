DCG
buildOldDCGRule: head body: body
	"Convert a DCG spec to a logic rule:
		s(a,b) --> np(a),vp(b)   ==>>  s(a,b,L1,L3) if np(a,L1,L2),vp(b,L2,L3)"

	
	| aStream |
	aStream := WriteStream on: String new.
	head printOn: aStream.
	head multiplicity > 0
		ifTrue:
			[aStream skip: -1.
			aStream write: ',']
		ifFalse: [aStream write: '('].
	aStream
		write: '?tokens1,?tokens' , (body terms size + 1) asString , ') if '.
	self convertDirectRuleCalls: body.
	body terms size = 1
		& (body terms first isKindOf: SoulFactory current makeList)
		ifTrue: [self buildTerminalbody: body on: aStream]
		ifFalse: [self buildNormalbody: body on: aStream].
	^(SoulFactory current makeParser
		parse: aStream contents
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString])
		clauses first