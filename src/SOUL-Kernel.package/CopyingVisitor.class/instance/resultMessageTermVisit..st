visiting terms
resultMessageTermVisit: rmTerm
	
	^SoulFactory current makeResultMessageTerm
		message: (rmTerm message accept: self)
		result: (rmTerm result accept: self)