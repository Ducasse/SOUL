soul auto saved
atomM1

"atom(?Term) succeeds if, and only if, ?Term is instantiated to a SOUL atom
	 (including the special atom denoting the empty list)"

atom(&Term) if 
	[(&Term isKindOf: UppedObject) | (&Term isKindOf: SmalltalkTerm)]