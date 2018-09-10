soul auto saved
sublistOfM2

sublistOf(?sublist,?list) if 
	append(?sublist,?,?list).
sublistOf(?sublist,<?|?rest>) if 
	sublistOf(?sublist,?rest)