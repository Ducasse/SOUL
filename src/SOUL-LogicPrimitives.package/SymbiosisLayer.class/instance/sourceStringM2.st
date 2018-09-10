soul auto saved
sourceStringM2

"This predicate extracts a resulting string from a quotedCode or produces a quotedcode from a string "

sourceString(?quotedCode,?SmalltalkString) if 
	quotedCode(?quotedCode),equals(?SmalltalkString,[?quotedCode asString]).
sourceString(?quotedCode,?SmalltalkString) if 
	var(?quotedCode),ground(?SmalltalkString),equals(?quotedCode,[DownedQuotedCode fromString: ?SmalltalkString])