binary relations
isProtocolInClassXM2

"isProtocolInClass/2 implements the 'is in' relation between protocols and classes. You can use it with any of the variables bound or unbound. 	As 	such, you can verify a relation, extract all relations, extract all protocols from a class or find the class in which a protocol is defined

CASE 1: ?Protocol unbound"

-?Protocol isProtocolInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk allProtocolsOfClass: ?Class] contains: ?Protocol.
"isProtocolInClass/2 implements the 'is in' relation between protocols and classes. You can use it with any of the variables bound or unbound. 	As 	such, you can verify a relation, extract all relations, extract all protocols from a class or find the class in which a protocol is defined

CASE 2: ?Protocol bound"

+?Protocol isProtocolInClass: ?Class if 
	?Class isClass,[MLI forSmalltalk isProtocol: ?Protocol ofClass: ?Class]