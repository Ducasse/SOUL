printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractTerm"

	
	id = #asClause
		ifTrue:
			[aStream tab.
			collection
				do: [:term | term prettyPrintOn: aStream scope: #asClause]
				separatedBy:
					[aStream write: ','.
					aStream crtab]]
		ifFalse:
			[collection
				do: [:term | term prettyPrintOn: aStream scope: #asTerm]
				separatedBy: [aStream write: ',']]