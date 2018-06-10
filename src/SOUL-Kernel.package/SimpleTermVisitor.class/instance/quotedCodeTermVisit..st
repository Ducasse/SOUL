visiting terms
quotedCodeTermVisit: aQuotedCodeBlock
	
	aQuotedCodeBlock variables do: [:subterm | subterm accept: self]