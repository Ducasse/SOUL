parser-printer
testSmalltalkTerms
	
	self processQuery: ' if equals([''Is this ok? yeah!''],?x)' description:
			'Can Smalltalkterms contain question marks and not recognize them as variables?'