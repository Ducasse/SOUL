template runtime
foundInXwithRestXM3

+?statement foundIn: <?statement|?next> withRest: ?next.
?statement foundIn: <?first|?next> withRest: ?nextStatements if 
	not(?statement equals: ?first),?statement foundIn: ?next withRest: ?nextStatements