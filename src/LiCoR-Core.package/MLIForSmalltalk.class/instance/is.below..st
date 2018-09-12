classes
is: subClass below: rootClass
	"returns true if subClass belongs to the hierarchy of rootClass (directly 
	or indirectly)"

	
	^rootClass withAllSubclasses includes: subClass