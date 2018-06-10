accessing-defaults
atAllDigitsPut: value
	" Set the value for all Characters
	that identify themselves as digits
	and that are outside the range of
	explicitly stored indices. "

	
	digitValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isDigit ifTrue: [self at: index put: value]]