evaluation
next
	"pop the currentframe from the stack, if it does not contain any  
	condition-clauses, it is a succes. Hence, it contains a result-binding  
	which is consequently fetched.  
	If it is not empty, set the data-stack to the position of the frame,  
	resolve the frame and expand the stack with the resulting frames"

	
	| currentFrame result |
	[(currentFrame := callstack pop) isEmpty]
		whileFalse: [self expandStack: (currentFrame resolveIn: env)].
	currentFrame rollback: env.
	result := currentFrame resultOf: vars in: env startAt: startedIndex.	"the end of the stack always contains a failframe, which should always 
	be returned if the next result is asked at the end of the eval process"

	result == false ifTrue: [callstack push: currentFrame].
	^result