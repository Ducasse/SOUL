evals
existsM2

"reimplemented

not tested

exists(+?Expression,+?Query) checks whether there exists a solution for ?Expression,
	for which the query ?Query is satisfied. Both ?Expression and ?Query must be
	instantiated with valid logic expressions."

exists(?Expression,?Query) if 
	exists(and(?Expression,?Query))