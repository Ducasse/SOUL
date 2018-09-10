soul auto saved
positiveIntegerM1

"tested on 02-07-2001

positiveInteger(+?N) tests whether ?N is a positive Smalltalk integer like 1, 2, 3, ... etc.
	 0 is also considered as a positive integer.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as positive integers by this predicate! Also note that the predicate fails when called
	 with a variable."

positiveInteger(?N) if 
	integer(?N),greaterOrEqual(?N,[0])