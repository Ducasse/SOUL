private
resizeVariables: minimum
	"TODO: use Array replaceFrom: to: with:"

	
	| newArray |
	variableMax := variableMax + (self incrementSize max: minimum).
	newArray := Array new: variableMax.
	1
		to: variableArray size
		do:
			[:i | 
			newArray
				at: i
				put: (variableArray at: i)].
	variableArray := newArray