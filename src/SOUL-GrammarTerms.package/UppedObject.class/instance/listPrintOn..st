printing
listPrintOn: aStream
	"this method is called if we are printed inside a list"

	
	aStream write: ','.
	self printOn: aStream