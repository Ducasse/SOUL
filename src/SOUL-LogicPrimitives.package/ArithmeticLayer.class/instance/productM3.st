soul auto saved
productM3

product(?N,?M,?NtimesM) if 
	atom(?N),var(?M),atom(?NtimesM),equals(?M,[?NtimesM / ?N]).
product(?N,?M,?NtimesM) if 
	var(?N),atom(?M),atom(?NtimesM),equals(?N,[?NtimesM / ?M]).
product(?N,?M,?NtimesM) if 
	atom(?N),atom(?M),var(?NtimesM),equals(?NtimesM,[?N * ?M]).
product(?N,?M,?NtimesM) if 
	atom(?N),atom(?M),atom(?NtimesM),equals(?NtimesM,[?N * ?M])