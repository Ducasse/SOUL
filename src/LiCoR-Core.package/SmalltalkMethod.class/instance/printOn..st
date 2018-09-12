printing
printOn: aStream
	
	aStream write: self fromClass asString , '>>' , self selector