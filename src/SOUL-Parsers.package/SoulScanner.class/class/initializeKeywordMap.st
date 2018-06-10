generated-initialization
initializeKeywordMap
	keywordMap := Dictionary new.
	#(#(18 'if' 9) #(18 'tabled' 3) #(19 'matches:' 17))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap