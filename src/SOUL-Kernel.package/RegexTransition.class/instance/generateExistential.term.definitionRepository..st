converting
generateExistential: identifier term: aTerm definitionRepository: aDefinitionRepository
	
	| string |
	string := (self generateExistentialHead: identifier term: aTerm)
		, (self generateExistentialCondition: identifier term: aTerm).
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository