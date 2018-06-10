private
generateSLGConclusion
	
	| functor |
	functor := self conclusion functor.
	functor isMessageFunctor
		ifTrue:
			[| result terms |
			terms := self conclusion termSequence terms.
			result := '?Id id: ' , (terms at: 1) asString , ' slg'.
			functor keywords
				doWithIndex:
					[:keyword :i | result := result , keyword asString , ': ' , (terms at: i + 1) asString].
			^result]
		ifFalse:
			[^'slg' , functor asString , '(?Id,'
				, self conclusion termSequence asString , ')']