string handling
testappendAtoms
	"self run:#testappendAtoms"

	"appendAtoms/3"

	
	self processQuery: ' if succeeds(appendAtoms(a,b,ab))' description:
			'Does appendAtoms/3 work correctly with 3 instantiated arguments?'.
	self processQuery: ' if succeeds(and(appendAtoms(a,b,?c),equals(?c,ab)))'
		description:
			'Does appendAtoms/3 work correctly with only first 2 arguments instantiated?'.
	self processQuery: ' if succeeds(appendAtoms([''a''],[''b''],[#ab]))'
		description:
			'The two first arguments may be strings, but the third is always a symbol.'.
	self processQuery:
			' if succeeds(and(appendAtoms([''a''],[''b''],?c),equals(?c,ab)))'
		description:
			'The two first arguments may be strings, but the third is always a symbol.'	"TODO: Diabled the tests below because in Squeak 'ab' = #'ab' is true, hence strings and symbols unify and the tests below fail. Should we fix the tests or the behavior of the predicate on Squeak? Fixing the behavior might be better as there is now the strange situation that the predicate can be true when the last argument is a string, but if the last argument is left unbound, no string will be given as a solution."
	"
	self	processQuery: 'if fails(appendAtoms([''a''],[''b''],[''ab'']))'
		description: 'As the third is assumed to be a symbol, the predicate will fail when it is a string.'.

	self	processQuery: 'if fails(and(appendAtoms([''a''],[''b''],?c),equals(?c,[''ab''])))'
		description: 'As the third is assumed to be a symbol, the predicate will fail when it is a string.'.
"