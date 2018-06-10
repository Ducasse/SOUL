visiting terms
termSequenceVisit: aTermSequence
	
	^aTermSequence class
		terms: (aTermSequence terms collect: [:subTerm | subTerm accept: self])