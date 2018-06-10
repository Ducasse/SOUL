private
conversionQueryStringForParseTree: parsetreerepresentation
	"Er wordt verwacht dat het resultaat van de template-resolutie ?result unificeert met ?resultTerm. Deze resolutie zal resultaten uit de Eclipse workspace ophalen, tenzij ?result al gebonden was aan ?resultTerm voor de resolutie begon. Om performantieoverwegingen wordt de conditie ?result equals: ?resultTerm daarom vooraan de gegenereerde query geplakt. Op methods en statements  zijn namelijk geen unificaties gedefinieerd die ervoor zouden kunnen zorgen dat er andere bindingen in de Eclipse workspace gevonden kunnen worden voor ?result die unificeren met ?resultTerm, maar er niet gelijk aan zijn. Op Eclipse expressions is dit wel gebeurd.

Concreet is het performantieverschil merkbaar bij de volgende query:
?s isStatement,
jtStatement(?s){return ?e;}
"

	
	| conversionQueryString functorName toBeLookedUpEvenIfGround |
	functorName := self type functor name.
	toBeLookedUpEvenIfGround := #(#jtExpression #jtClassDeclaration #jtInterfaceDeclaration #jtMethodDeclaration).
	conversionQueryString := 'if ' , parsetreerepresentation asString ,
			' templateUnderInterpretation: ?interpretationFooBar123 compilesTo: ?tempquery forResult: ?resultFooBar123 : ?annotation '.
	conversionQueryString := conversionQueryString
		,
			((toBeLookedUpEvenIfGround includes: functorName)
				ifTrue:
					[', append('
						,
							(self hasInterpretationArgument
								ifTrue:
									['<?interpretationFooBar123 equals: ?interpretationTerm | ?tempquery>']
								ifFalse: ['?tempquery']) ,
							', <?resultFooBar123 equals: ?resultTerm>, ?query)']
				ifFalse:
					[', ?query equals: <'
						,
							(self hasInterpretationArgument
								ifTrue: ['?interpretationFooBar123 equals: ?interpretationTerm,']
								ifFalse: ['']) ,
							' ?resultFooBar123 equals: ?resultTerm | ?tempquery>']).
	^conversionQueryString