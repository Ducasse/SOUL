iterators
forallM1

"forall(?query) checks whether all possible evaluation paths for ?query succeed.
	 If the ?query itself fails, then forall/1 also fails as there are no evaluation paths for
	?query that have succeeded."

forall(?query) if 
	exists(?query),forall(?query,[true])