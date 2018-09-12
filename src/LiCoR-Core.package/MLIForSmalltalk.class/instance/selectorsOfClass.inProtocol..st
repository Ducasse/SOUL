methods
selectorsOfClass: aClass inProtocol: aProtocolName
	"computes the list of all selectors in the protocol with name  
	aProtocolName of class aClass"

	
	^aClass organization listAtCategoryNamed: aProtocolName