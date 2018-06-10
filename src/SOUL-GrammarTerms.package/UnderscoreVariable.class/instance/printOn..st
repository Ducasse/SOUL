printing
printOn: aStream
	"see comment in QSOULAbstractTerm"

	"Why not simply write: $? instead of Character value:63... well, if the  
	QSOULparsetreegenerator wanted to parse this (because I request the  
	parsetree of this method), it would generate a fact containing '?'  
	somewhere. Later on, the QSOUL interpreter would see a variable...  
	very confusing indeed"

	
	aStream write: (Character value: 63)