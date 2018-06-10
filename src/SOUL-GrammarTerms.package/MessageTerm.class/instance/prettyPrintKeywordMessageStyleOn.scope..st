printing
prettyPrintKeywordMessageStyleOn: aStream scope: id
	
	| newId |
	id = #asClause
		ifTrue: [newId := #asClause]
		ifFalse: [newId := #asTerm].
	self receiver prettyPrintAsKeywordArgOn: aStream scope: newId.
	aStream write: ' '.
	self functor keywords
		with: (termsequence terms allButFirst: 1)
		do:
			[:keyword :aterm | 
			keyword prettyPrintAsKeywordOn: aStream scope: newId.
			aStream write: ': '.
			aterm prettyPrintAsKeywordArgOn: aStream scope: #asTerm]
		separatedBy: [aStream write: ' ']