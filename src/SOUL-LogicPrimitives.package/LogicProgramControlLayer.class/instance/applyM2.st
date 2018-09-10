evals
applyM2

"apply(?PredicateName,?ArgumentList) applies the predicate with name ?PredicateName to a
	 given ?ArgumentList. For example, apply(foo,<bar,zork>) is equivalent to calling foo(bar,zork)."

apply(?PredicateName,?ArgumentList) if 
	equalsStructureList(?Query,<?PredicateName|?ArgumentList>),?Query