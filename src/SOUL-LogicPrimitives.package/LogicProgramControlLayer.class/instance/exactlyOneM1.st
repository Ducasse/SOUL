evals
exactlyOneM1

"tested on 09-07-2001

exactlyOne(+?Query) tests whether some ?Query produces exactly one result. Note that
	 the query is supposed to be instantiated upon calling this predicate."

exactlyOne(+?Query) if 
	findall(dummy,?Query,<?>),?Query