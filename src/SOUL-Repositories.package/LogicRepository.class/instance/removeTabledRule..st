private
removeTabledRule: aTabledRule
	
	aTabledRule generatedRules
		do: [:generated | self removeClause: generated cleanupGenerated: true].
	tabledRules
		remove: aTabledRule
		ifAbsent: [^self halt]