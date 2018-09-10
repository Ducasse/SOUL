soul auto saved
privateIntersectionListsRecursionM3

"intersect the first argument (with the already intersected lists) with the first
	element of the ones to do (the head of the second argument). Then do a recursive step.
	When the recursion returns, ?intersection will have the result"

privateIntersectionListsRecursion(?done,<?todoFirst|?todoRest>,?intersection) if 
	intersection(?done,?todoFirst,?intersectedFirst),privateIntersectionListsRecursion(?intersectedFirst,?todoRest,?intersection).
"stop condition: nothing more to do (the second list), so the resulting intersection is in ?L.
	Assign this as the solution. Because we are now at the deepest  recursin level,
	we will now rise again to the top, passing the result in the last variable"

privateIntersectionListsRecursion(?L,<>,?L)