printing
printAsPrologFunctorOn: aStream scope: id in: env startAt: idx
	"This method should print the textual representation of the term when it  
	is used as a functor. This is necessary if uppedobjects are used as  
	functors"

	
	self printAsPrologOn: aStream scope: id in: env startAt: idx