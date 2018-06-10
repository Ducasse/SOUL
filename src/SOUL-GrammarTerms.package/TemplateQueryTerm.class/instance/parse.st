private
parse
	"Delay parsing, if necessary, to after the loading of the entire repository"

	"Soul.Factory doAfterRepositoryLoad: [self setParseTree]."

	
	parsetrees := self asParseTrees.
	queries := self asQueries.
	^super parse