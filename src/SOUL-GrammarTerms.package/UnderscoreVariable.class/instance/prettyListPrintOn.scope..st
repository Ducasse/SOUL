printing
prettyListPrintOn: aStream scope: id
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printOn: aStream