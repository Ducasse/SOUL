methods
isSelectorOfClassXinProtocolXM3

"isSelectorOfClass: verifies whether ?Selector is the name of a
	 method in the protocol with name ?Protocol of class ?Class, or works in a more generative way
	 if one or more of the variables are uninstantiated.

Case 1: ?Selector is unbound"

-?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol if 
	?Protocol isProtocolInClass: ?Class,[MLI current selectorsOfClass: ?Class inProtocol: ?Protocol] contains: ?Selector.
"isSelectorOfClass: verifies whether ?Selector is the name of a
	 method in the protocol with name ?Protocol of class ?Class, or works in a more generative way
	 if one or more of the variables are uninstantiated.

Case 2: ?Selector is bound"

+?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol if 
	?Protocol isProtocolInClass: ?Class,[MLI current isSelector: ?Selector ofClass: ?Class inProtocol: ?Protocol]