access
predicate
	"For storing this kind of term in the logic database, this method creates a unique key to identify this term when the resolution process needs to retrieve it 	from the logic database. The default behaviour is generates an error."

	
	^self
		error:
			'Cannot store a term with as conclusion a ' , self class asString ,
					' in the logic repository'