template parsing
makeKeywordMessage2M3

makeKeywordMessage2(<>,<>,<>).
makeKeywordMessage2(<key(?firstkey,?firstArg)|?keys>,<?firstkey|?resKey>,<?firstArg|?resArgs>) if 
	makeKeywordMessage2(?keys,?resKey,?resArgs)