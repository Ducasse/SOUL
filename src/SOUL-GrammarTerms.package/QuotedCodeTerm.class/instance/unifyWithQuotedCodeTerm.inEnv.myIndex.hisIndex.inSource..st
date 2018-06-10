unification
unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"TODO: how to unify quotedCode? Currently we, compare strings. An  
	alternative is in the comment"

	"a quotedCode unifies with another quotedCode if all subterms unify  
	| index succes |  
	succes _ true.  
	index _ 1.  
	self terms size == aQCTerm terms size  
	ifFalse: [^ false].  
	aQCTerm terms  
	do: [:otherTerm |  
	succes  
	ifTrue: [succes _ otherTerm  
	unifyWith: (content at: index)  
	inEnv: anEnv].  
	index _ index + 1].  
	^ succes"

	
	^(self asSourceStringIn: anEnv startAt: myIndex)
		= (aQCTerm asSourceStringIn: anEnv startAt: hisIndex)