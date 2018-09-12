packaging - binary relations
isProtocol: aProtocolName ofClass: aClass
	"Checks whether aProtocolName is the name of a protocol in the class 
	aClass "

	
	^aClass organization categories includes: aProtocolName