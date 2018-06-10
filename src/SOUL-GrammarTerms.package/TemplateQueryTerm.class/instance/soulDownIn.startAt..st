reification
soulDownIn: anEnv startAt: anIndex
	"DownedQuotedCode represents the QuotedCode construct on the  
	smalltalk-level. We also down our contents to allow an up later on"

	
	| string newcontent newvariables newparsetrees newqueries |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el soulDownIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | (el soulDownIn: anEnv startAt: anIndex) soulUp].
	newparsetrees := parsetrees
		collect: [:tree | (tree soulDownIn: anEnv startAt: anIndex) soulUp].
	newqueries := queries
		collect:
			[:tree | 
			Array
				with: ((tree at: 1) transitiveLookupIn: anEnv startAt: anIndex) soulUp
				with: (tree at: 2)].
	^DownedTemplateQuery fromString: string variables: newvariables content:
			newcontent block: block parsetrees: newparsetrees queries: newqueries
		type: type