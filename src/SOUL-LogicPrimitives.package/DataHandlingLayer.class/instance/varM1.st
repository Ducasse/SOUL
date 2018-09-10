soul auto saved
varM1

"tested on 21/08/2001

var(+-?Term) succeeds if, and only if, ?Term is an unbound variable.
	 An unbound variable is one which has not been bound to another term
	 (other than another uninstantiated variable)."

var(&Term) if 
	[&Term isKindOf: SoulFactory current makeVariable]