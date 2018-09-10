bad imperative  predicates
doM1

"do(?Action) does a certain ?Action for its side-effects. Whether are not the action succeeds
	 or fails we don't care, the do-predicate will execute the side-effects and will always succeed."

do(?Action) if 
	succeeds(or(?Action,[true]))