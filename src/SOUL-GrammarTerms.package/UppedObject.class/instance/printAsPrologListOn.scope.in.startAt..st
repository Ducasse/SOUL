printing
printAsPrologListOn: aStream scope: scope in: env startAt: idx
	"this method is called if we are printed inside a list"

	
	aStream write: ','.
	self printAsPrologOn: aStream scope: scope in: env startAt: idx