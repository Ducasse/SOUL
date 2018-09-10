soul auto saved
subM3

"tested on 02-07-2001"

sub(?N,?M,?NminusM) if 
	atom(?N),var(?M),atom(?NminusM),equals(?M,[?N - ?NminusM]).
sub(?N,?M,?NminusM) if 
	var(?N),atom(?M),atom(?NminusM),equals(?N,[?M + ?NminusM]).
sub(?N,?M,?NminusM) if 
	atom(?N),atom(?M),var(?NminusM),equals(?NminusM,[?N - ?M]).
sub(?N,?M,?NminusM) if 
	atom(?N),atom(?M),atom(?NminusM),equals(?NminusM,[?N - ?M])