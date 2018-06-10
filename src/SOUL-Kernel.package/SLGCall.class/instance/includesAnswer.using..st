testing
includesAnswer: anAnswerTerm using: delayed
	"Do we already include the answer?"

	
	| pos neg possibleAnswers |
	pos := ((delayed at: 1) collect: [:d | d cid]) sort.
	neg := ((delayed at: 2) collect: [:d | d cid]) sort.
	possibleAnswers := answers
		select: [:a | (a at: 1) isSLGEquivalentTo: anAnswerTerm].	"we now have all the answers, we now have to check if this new answer has the same delayed variables"

	possibleAnswers
		detect:
			[:a | 
			| del |
			del := a at: 2.
			((del at: 1) collect: [:d | d cid]) sort = pos
				and: [((del at: 2) collect: [:d | d cid]) sort = neg]]
		ifNone: [^false].
	^true