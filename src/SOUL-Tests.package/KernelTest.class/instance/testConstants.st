symbiosis
testConstants
	"self run:#testConstants"

	
	self processQuery: ' if succeeds(equals(a,[#a]))' description:
			'Testing shortcut notation for constant symbols.'.
	self processQuery: ' if succeeds(equals([#a],a))' description:
			'Testing shortcut notation for constant symbols.'.
	self processQuery: ' if succeeds(equals(1,[1]))' description:
			'Testing shortcut notation for constant integers.'.
	self processQuery: ' if succeeds(equals([1],1))' description:
			'Testing shortcut notation for constant integers.'.
	self processQuery: ' if fails(equals([Array],Array))' description:
			'Of course there is no shortcut notation for Smalltalk classes."'