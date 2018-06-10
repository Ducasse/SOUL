private
removeGeneratedRules
	
	tabledRules
		do:
			[:aTabledRule | 
			| generated |
			generated := aTabledRule generatedRules.
			generated do: [:aRule | self removeClause: aRule].	"not sure if they are re-used or re-generated, so clearing to be safe"

			aTabledRule generatedRules: OrderedCollection new].
	tabledRules := OrderedCollection new