soul auto saved
constrainM2

"tested

constrain/2 does a generate and check operation, in other words a kind of domain check. For example:
		constrain(?c, [Smalltalk allClasses])
	If ?c has a value, then it is ensured that this is a Smalltalk class.   
	if ?c is a variable, values for ?c are generated"

constrain(?term,?smalltalkTerm) if 
	nonvar(?smalltalkTerm),collectionMember(?generatedTerm,?smalltalkTerm),equals(?term,?generatedTerm)