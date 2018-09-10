bad imperative  predicates
ifThenElseM3

"ifThenElse(?Condition,?True,?False) executes the ?True action when the
	 ?Condition is satisfied and executes the ?False action if not."

ifThenElse(?Condition,?True,?False) if 
	case(cond(?Condition,?True),cond([true],?False))