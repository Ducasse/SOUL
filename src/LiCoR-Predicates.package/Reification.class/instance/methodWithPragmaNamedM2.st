method attributes
methodWithPragmaNamedM2

methodWithPragmaNamed(-?method,+?name) if 
	class(?class),member(?method,[MLI forSmalltalk
	methodsInClass: ?class
	withPragmaName: ?name asSymbol]).
methodWithPragmaNamed(+?method,+?name) if 
	methodInClass(?method,?class),member(?method,[MLI forSmalltalk
	methodsInClass: ?class
	withPragmaName: ?name asSymbol])