accessing-defaults
atAllLettersPut: value
	" Set the value for all Characters
	that identify themselves as letters
	and that are outside the range of
	explicitly stored indices. "

	
	letterValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isLetter ifTrue: [self at: index put: value]]