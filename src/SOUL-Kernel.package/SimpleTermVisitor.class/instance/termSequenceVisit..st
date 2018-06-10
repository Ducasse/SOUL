visiting terms
termSequenceVisit: aTermSequence
	
	aTermSequence terms do: [:subTerm | subTerm accept: self]