soul auto saved
sub1M2

"tested on 02-07-2001"

sub1(?N,?Nminus1) if 
	var(?N),atom(?Nminus1),equals(?N,[?Nminus1 + 1]).
sub1(?N,?Nminus1) if 
	atom(?N),var(?Nminus1),equals(?Nminus1,[?N - 1]).
sub1(?N,?Nminus1) if 
	atom(?N),atom(?Nminus1),equals(?Nminus1,[?N - 1])