reification
soulUp
	"produce an upped quotedcode of this downed quotedcode"

	
	^QuotedCodeTerm
		source: self asString
		variables: variables
		content: content
		block: block