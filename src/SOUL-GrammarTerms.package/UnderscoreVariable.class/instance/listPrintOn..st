printing
listPrintOn: aStream
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printOn: aStream