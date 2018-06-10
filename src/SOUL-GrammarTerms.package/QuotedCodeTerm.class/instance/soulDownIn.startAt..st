reification
soulDownIn: anEnv startAt: anIndex
	"DownedQuotedCode represents the QuotedCode construct on the  
	smalltalk-level. We also down our contents to allow an up later on"

	
	| string newcontent newvariables |
	string := self asSourceStringIn: anEnv startAt: anIndex.
	newvariables := variables
		collect:
			[:el | 
			el
				ifNil: [nil]
				ifNotNil: [(el soulDownIn: anEnv startAt: anIndex) soulUp]].
	newcontent := content
		collect: [:el | (el soulDownIn: anEnv startAt: anIndex) soulUp].
	^DownedQuotedCode fromString: string variables: newvariables content:
			newcontent block: block