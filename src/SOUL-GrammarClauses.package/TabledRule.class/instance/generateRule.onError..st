private
generateRule: aString onError: aBlock
	
	| newRule |
	newRule := (SoulFactory current makeParser parse: aString onError: aBlock)
		clauses first.
	newRule recursiveDefinitionRepository: self definitionRepository.	"newRule condition definitionRepository: (self definitionRepository).
 	newRule conclusion definitionRepository: (self definitionRepository).
	newRule definitionRepository: (self definitionRepository)."

	self generatedRules add: newRule.
	^newRule