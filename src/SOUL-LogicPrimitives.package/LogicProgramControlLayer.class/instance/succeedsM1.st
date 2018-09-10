evals
succeedsM1

"tested; to be made more efficient once one/1 has been debugged

succeeds(+?Query) succeeds if ?Query succeeds and fails otherwise.
?Query is supposed to be instantiated with a valid logic query."

succeeds(&Query) if 
	one(&Query)