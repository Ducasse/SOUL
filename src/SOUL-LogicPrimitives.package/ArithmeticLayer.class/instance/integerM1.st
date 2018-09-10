soul auto saved
integerM1

"tested on 02-07-2001

integer(+?N) tests whether ?N is a Smalltalk integer like -1, 2, 0, 7 etc.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as integers by this predicate! Also note that the predicate fails when called
	 with a variable."

integer(?N) if 
	[?N isInteger]