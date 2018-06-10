add/del - runtime
assert: aText
	
	| program |
	"Add a program in textformat to the repository"

	program := SoulFactory current makeParser
		parse: aText
		onError: [:e :i | self error: 'Not a valid Soul clause'].
	self addProgram: program.
	^true