methods
isMethodInClassXinProtocolXM3

"Is ?Method of class ?Class classified in protocol ?Protocol?
Case 1: ?Method is bound"

+?Method isMethodInClass: ?Class inProtocol: ?Protocol if 
	?Method isMethodWithName: ?Selector inClass: ?Class,?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol.
"Is ?Method of class ?Class classified in protocol ?Protocol?
Case 2: ?Method is bound"

-?Method isMethodInClass: ?Class inProtocol: ?Protocol if 
	?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol,?Method isMethodWithName: ?Selector inClass: ?Class