visiting terms
callTermVisit: aCallTerm
	
	^aCallTerm class
		variable: (aCallTerm variable accept: self)
		term: (aCallTerm normalterm accept: self)