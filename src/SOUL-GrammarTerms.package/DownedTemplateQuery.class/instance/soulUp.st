reification
soulUp
	"produce an upped quotedcode of this downed quotedcode"

	
	^SoulFactory current makeTemplateQuery
		source: self asString
		variables: variables
		content: content
		block: block
		parsetrees: trees
		queries: queries
		type: type