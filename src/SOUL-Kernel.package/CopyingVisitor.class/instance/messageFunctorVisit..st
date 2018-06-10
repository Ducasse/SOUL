visiting terms
messageFunctorVisit: term
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term