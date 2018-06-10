printing
printAsPrologOn: aStream
	
	| processedVariables |
	conclusion printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: ' :- ';
		crtab.	"UGLY: bweeeuuuk...."

	processedVariables := Set new.
	conclusion
		accept:
			(SoulFactory current makeNamedVariableVisitor
				doBlock:
					[:aVariable | 
					(aVariable isKindOf: PosVariable)
						& (processedVariables includes: aVariable) not
						ifTrue:
							[processedVariables add: aVariable.
							aStream write: 'nonvar('.
							aVariable printAsPrologOn: aStream scope: #asTerm in: nil startAt:
									nil.
							aStream
								write: '),';
								crtab].
					(aVariable isKindOf: NegVariable)
						& (processedVariables includes: aVariable) not
						ifTrue:
							[processedVariables add: aVariable.
							aStream write: 'var('.
							aVariable printAsPrologOn: aStream scope: #asTerm in: nil startAt:
									nil.
							aStream
								write: '),';
								crtab]]).
	condition printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: '.';
		cr