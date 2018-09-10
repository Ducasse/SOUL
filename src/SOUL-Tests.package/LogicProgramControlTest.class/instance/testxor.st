meta programming
testxor
	"self run:#testxor"

	"xor/2"

	
	self processQuery: ' if succeeds(xor(integer([1]),var([1])))' description:
			'Does xor/2 succeed when first argument succeeds and second fails?'.
	self processQuery: ' if succeeds(xor(integer(?x),var(?x)))' description:
			'Does xor/2 succeed when first argument fails and second succeeds?'.
	self processQuery: ' if fails(xor(integer([1]),positiveInteger([1])))'
		description: 'Does xor/2 fail when both arguments are true?'.
	self processQuery: ' if fails(xor(zero([1]),positiveInteger([-1])))'
		description: 'Does xor/2 fail when both arguments fail?'.
	self processQuery:
			' if fails(xor(equals(?x,[#first]),equals(?y,[#second])))' description:
			'Does xor/2 when both arguments succeed?'.
	self processQuery:
			' if succeeds(and(equals(?x,[#dummy]),xor(equals(?x,[#first]),equals(?y,[#second])),nonvar(?x),equals(?x,[#dummy]),nonvar(?y),equals(?y,[#second])))'
		description:
			'Can xor/2 be used to select the second of two instructions?'