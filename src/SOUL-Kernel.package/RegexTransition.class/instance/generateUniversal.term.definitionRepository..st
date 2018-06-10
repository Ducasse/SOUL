converting
generateUniversal: identifier term: aTerm definitionRepository: aDefinitionRepository
	
	| string |
	string := (self generateUniversalHead: identifier term: aTerm)
		, (self generateUniversalCondition: identifier term: aTerm).
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository