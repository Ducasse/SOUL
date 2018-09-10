soul auto saved
listAsSeparatedStringM3

"listAsSeparatedString(?ListOfSymbols,?Separator, ?String) turns a ?ListOfSymbols (or
	 strings) into a ?String with all those symbols in the order in which they
	 appear in the list separated by a ?Separator. No extra ?Separator at the end is
	 produced.

Note: a variant for this predicate that works on quoted terms instead of symbols/strings is concatQuotedTerms/3.

Special case: needed for when the empty list is passed as argument."

listAsSeparatedString(<>,?,['']).
"Base case: stop without a space if the list just contains one single element."

listAsSeparatedString(<?el>,?,[?el asString]).
"Recursive case: take the first element followed by a space, followed by a
	 the other elements."

listAsSeparatedString(<?el|?rest>,?Separator,?string) if 
	not(emptyList(?rest)),listAsSeparatedString(?rest,?Separator,?reststring),equals(?string,[?el asString , ?Separator , ?reststring])