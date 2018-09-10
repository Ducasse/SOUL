evals
xorM2

"tested on 09-07-2001

xor(+?Query1,+?Query2) takes two queries as inputs and succeeds if and only if
	 one of both queries succeeds and the other one fails. Both queries are supposed
	 to be filled in before calling this predicate. xor/2 gives an error when called with
	 one of the arguments variable."

xor(&Query1,&Query2) if 
	or(and(&Query1,not(&Query2)),and(&Query2,not(&Query1)))