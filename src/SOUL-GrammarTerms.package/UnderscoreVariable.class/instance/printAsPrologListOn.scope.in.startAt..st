printing
printAsPrologListOn: aStream scope: scope in: env startAt: idx
	"Needed to display < ?avar  | ? > in SoulInteractive"

	
	aStream write: '|'.
	self printAsPrologOn: aStream scope: scope in: env startAt: idx