accessing-defaults
atAllSeparatorsPut: value
	" Set the value for all Characters
	that identify themselves as separators
	and that are outside the range of
	explicitly stored indices. "

	
	separatorValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isSeparator ifTrue: [self at: index put: value]]