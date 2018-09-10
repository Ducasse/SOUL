soul auto saved
groundM1

"tested on 05-07-2001

ground(+-?Term) succeeds if ?Term is currently instantiated to a term that is completely 
	 bound (has no uninstantiated variables in it); otherwise it fails"

ground(&X) if 
	[| result varVisitor |
result := true.
varVisitor := AllButHiddenVariablesVisitor
	doBlock: [:var | result := false].
&X accept: varVisitor.
result]