evals
failsM1

"tested

fails(+?Query) succeeds if ?Query fails and succeeds if ?Query fails.
?Query is supposed to be instantiated with a valid logic query."

fails(&Query) if 
	not(&Query)