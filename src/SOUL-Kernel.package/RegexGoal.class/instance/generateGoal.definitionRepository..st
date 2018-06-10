converting
generateGoal: aTerm definitionRepository: aDefinitionRepository
	
	| string |
	termsequence size = 0
		ifTrue:
			[string := string := 'goal' , aTerm identifier asString , '('
				, goalId asString , ',' , variables asString , ', ?currentWorld)']
		ifFalse:
			[string := 'goal' , aTerm identifier asString , '(' , goalId asString , ','
				, variables asString , ', ?currentWorld) if ' , termsequence asString].
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository