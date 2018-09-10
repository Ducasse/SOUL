soul auto saved
startsAndEndsWithM3

"CASE 1: ?Start and ?End are known"

startsAndEndsWith(?AString,+?Start,+?End) if 
	string(?Start),string(?End),equals(?AString,[?Start speciesAppend: ?End]).
"CASE 2: ?AString and ?Start are known"

startsAndEndsWith(+?AString,+?Start,-?End) if 
	string(?AString),string(?Start),[?Start , '*' match: ?AString],equals(?End,[?AString
	speciesCopyFrom: ?Start size + 1
	to: ?AString size]).
"CASE 3: ?AString and ?End are known"

startsAndEndsWith(+?AString,-?Start,+?End) if 
	string(?AString),string(?End),['*' , ?End match: ?AString],equals(?Start,[?AString
	speciesCopyFrom: 1
	to: ?AString size - ?End size])