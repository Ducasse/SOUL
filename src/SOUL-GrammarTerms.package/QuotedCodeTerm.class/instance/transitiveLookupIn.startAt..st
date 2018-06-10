reification
transitiveLookupIn: anEnv startAt: anIndex
	
	| string newvariables newcontent |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [el transitiveLookupIn: anEnv startAt: anIndex]].
	newcontent := content
		collect: [:el | el transitiveLookupIn: anEnv startAt: anIndex].
	^QuotedCodeTerm source: string variables: newvariables content: newcontent
		block: block