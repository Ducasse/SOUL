methods
isSelector: aSelector ofClass: aClass inProtocol: aProtocolName
	"checks whether aSelector is the name of a method in the protocol with 
	name aProtocolName of the class aClass"

	
	^(aClass organization listAtCategoryNamed: aProtocolName) includes:
			aSelector