list handling
testnoDups
	"self run: #testnoDups"

	"self debug: #testnoDups"

	
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,c>,?nodups),sameElements(?nodups,<a,b,d,c>)))'
		description:
			'What is the non-duplicates list of a non-duplicates containing list?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,c>,<a,b,d,c>))'
		description:
			'Test the non-duplicates list of a non-duplicates containing list.'.
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,b,a,c,b,c>,?nodups),length(?nodups,4)))'
		description: 'Does noDups/2 actually remove duplicates?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,b,a,c,b,c>,<a,b,d,c>))'
		description:
			'Test the non-duplicates list of a list containing duplicates.'.
	self processQuery: ' if succeeds(noDups(<a,b,d,b,a,c,b,c>,<d,c,b,a>))'
		description:
			'Test the non-duplicates list of a list containing duplicates.'.
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,b,a,c,c,c,b,a>,?nodups),sameElements(?nodups,<a,b,d,c>)))'
		description:
			'What is the non-duplicates list of a duplicates containing list?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,c>,<c,b,a,d>))'
		description:
			'What is the list with duplicates for a result list containing no duplicates?'.
	self processQuery: ' if fails(noDups(?res,<c,b,a,d,c>))' description:
			'Does noDups/2 fail when first argument is uninstantiated?'.
	self processQuery: ' if succeeds(noDups(<[Array]>,?no))' description:
			'Does noDups/2 succeeds for <[Array]>?'