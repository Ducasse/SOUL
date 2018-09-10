soul auto saved
counterincrM1

"This predicate has a non-decarative semantics, it is meant mostly for writing test cases were there's a need to test the number of times a query is executed for example."

counterincr(+?x) if 
	[?x
	at: 1
	put: (?x at: 1) + 1.
true].
counterincr(-?x) if 
	equals(?x,[Array with: 1])