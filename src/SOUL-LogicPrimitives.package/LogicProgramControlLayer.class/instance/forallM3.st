iterators
forallM3

"tested 03/04/2002

implemented by KM - 03/04/2002

forall(?query, ?test, ?failures) is related to forall/2, but also returns the elements from ?query 
	that failed the ?test. These are returned in the ?failures list. In fact, it is more like a findall/3 in
	the sense that it accumulates a list of all solutions of ?query that fail the ?test.
	Note: The regular forall stops with the first element it encounters that does 
		not satisfy ?test. This forall/3 does not: it will check for all results 
		of query too whether they satisfy ?test or not.

For example:	forall(	member(?e,<[1], [2], [3]>),	equals(?e, [2]),	?L)
	 yields:	?L -> < equals([1],[2]), equals([3],[2])>
	 because [1] and [3] failed the ?test but satisfied the ?query"

forall(?query,?test,?failures) if 
	findall(?test,and(?query,not(?test)),?failures)