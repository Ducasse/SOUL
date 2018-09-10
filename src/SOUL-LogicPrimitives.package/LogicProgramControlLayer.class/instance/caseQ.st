soul auto saved
caseQ

"case is a predicate that can take an arbitrary list of parameters of the form
	 cond(?Condition,?Action). It works as follows: the ?Action corresponding to the
	 first succesful ?Condition is executed. The remaining conditions and actions
	 are then ignored (in other words, only one case can be fired)."

case@(<cond(?Condition,&Action)|?Cases>) if 
	one(or(and(?Condition,do(&Action)),apply(case,?Cases)))