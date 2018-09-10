template basics
parseM3

"This predicate is necessary and should not be removed. It is called by the typedquotedcodes to parse their contents"

parse(?type,?string,?tree) if 
	scan(?type,?string,?tokens),?type(?tree,?tokens,<>)