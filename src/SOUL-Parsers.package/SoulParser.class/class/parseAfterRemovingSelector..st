parsing
parseAfterRemovingSelector: aCode
	
	| selector index offset program input |
	input := aCode contents.
	selector := Parser new parseSelector: input.
	index := selector size.	"JF- Adding spaces in front ensures error messages are put at the right offset"

	offset := (input indexOf: Character cr) - 1 max: 1.
	program := (String
		new: offset
		withAll: Character space) asText , (input allButFirst: index).
	^self parse: program