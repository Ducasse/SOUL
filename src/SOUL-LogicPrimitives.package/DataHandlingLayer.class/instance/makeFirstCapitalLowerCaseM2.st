soul auto saved
makeFirstCapitalLowerCaseM2

"Soul.SoulTests.DataHandlingTest run: #testmakeFirstCapitalLowerCase

makeFirstCapitalLowerCase(+?String,+-?NewString) transforms a ?String into a new one where
 the first characted is converted into a lower case one (if it was already a lower case one, the new
 string is just a copy of the old one"

makeFirstCapitalLowerCase(?String,?NewString) if 
	string(?String),equals(?NewString,[| x |
x := ?String copy.
x
	at: 1
	put: x first asLowercase.
x])