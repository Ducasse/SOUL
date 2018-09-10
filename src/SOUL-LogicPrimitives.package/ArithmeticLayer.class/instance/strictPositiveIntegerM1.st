soul auto saved
strictPositiveIntegerM1

"tested on 02-07-2001

strictPositiveInteger(+?N) tests whether ?N is a strict positive Smalltalk integer
	 like 1, 2, 3, ... etc. 0 is NOT considered as a strict positive integer.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as strict positive integers by this predicate! Also note that the predicate fails
	 when called with a variable."

strictPositiveInteger(?N) if 
	integer(?N),greater(?N,[0])