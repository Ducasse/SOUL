term comparison and sorting
testdiffers
	"differs/2"

	
	self processQuery: ' if fails(differs(?X,?Y))' description:
			'Are two unbound logic variables NOT different?'.
	self processQuery: ' if fails(differs([1],[1]))' description:
			'Are two equal integers not different?'.
	self processQuery: ' if succeeds(differs([1],[2]))' description:
			'Are two unequal integers different?'.
	self processQuery: ' if fails(differs([1],1))' description:
			'Are the Smalltalk integer 1 and logic constant 1 not different?'.
	self processQuery: ' if fails(differs([#test],test))' description:
			'Are a Smalltalk symbol and its corresponding logic term not different?'