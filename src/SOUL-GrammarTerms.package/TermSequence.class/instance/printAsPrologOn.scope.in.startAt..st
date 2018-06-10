printing
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	id = #asClause
		ifTrue:
			[collection
				do:
					[:term | term printAsPrologOn: aStream scope: #asClause in: env startAt: idx]
				separatedBy:
					[aStream write: ','.
					aStream crtab]]
		ifFalse:
			[collection
				do:
					[:term | term printAsPrologOn: aStream scope: #asTerm in: nil startAt: nil]
				separatedBy: [aStream write: ',']]