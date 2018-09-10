iterators
filterDupsM2

filterDups(<>,<>).
filterDups(<?car|?cdr>,?rest) if 
	member(?car,?cdr),filterDups(?cdr,?rest).
filterDups(<?car|?cdr>,<?car|?rest>) if 
	not(member(?car,?cdr)),filterDups(?cdr,?rest)