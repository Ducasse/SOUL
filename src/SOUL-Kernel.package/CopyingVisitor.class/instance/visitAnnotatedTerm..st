visiting terms
visitAnnotatedTerm: aTerm
	
	^aTerm class
		term: (aTerm term accept: self)
		annotation: (aTerm annotation accept: self)