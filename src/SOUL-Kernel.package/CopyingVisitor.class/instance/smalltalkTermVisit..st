visiting terms
smalltalkTermVisit: anSTTerm
	"TODO: this might not work properly if we use the copyingvisitor to write a renaming tool for variables for example ..."

	"UGLY: yukky type test here"

	
	^anSTTerm class
		source: anSTTerm source
		variables:
			(anSTTerm variablesIncludingNils
				collect:
					[:x | 
					(x isKindOf: AbstractTerm)
						ifTrue: [x accept: self]
						ifFalse: [x]])
		content: anSTTerm content
		block: anSTTerm block