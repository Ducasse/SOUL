access
clausesDo: aBlock
	
	| multArray clauses |
	self compile.	"clauseArray do: [ :multArray |
		multArray ifNotNil: [ x do: [ :clauseCollection | 
			clauseCollection ifNotNil: [ clauseCollection do: [ :clause |
				aBlock value: clause
			] ]
		] ]
	]"

	(1 to: currentAddress)
		do:
			[:index | 
			multArray := clauseArray at: index.
			(1 to: multArray size)
				do:
					[:idx | 
					clauses := multArray at: idx.
					clauses do: [:clause | aBlock value: clause]]]