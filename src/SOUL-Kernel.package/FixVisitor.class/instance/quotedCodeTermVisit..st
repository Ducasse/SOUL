visiting terms
quotedCodeTermVisit: aQuotedCodeBlock
	
	aQuotedCodeBlock variables do: [:var | var accept: self].
	aQuotedCodeBlock content do: [:var | var accept: self]