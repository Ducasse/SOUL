reification
transitiveLookupIn: anEnv startAt: anIndex
	
	| string newvariables newcontent newparsetrees newqueries |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el transitiveLookupIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | el transitiveLookupIn: anEnv startAt: anIndex].
	newparsetrees := parsetrees
		collect:
			[:tree | (tree transitiveLookupIn: anEnv startAt: anIndex) soulUp].
	newqueries := queries
		collect:
			[:tree | 
			Array
				with: ((tree at: 1) transitiveLookupIn: anEnv startAt: anIndex) soulUp
				with: (tree at: 2)].
	^SoulFactory current makeTemplateQuery source: string variables: newvariables
		content: newcontent block: block parsetrees: newparsetrees queries:
			newqueries type: type