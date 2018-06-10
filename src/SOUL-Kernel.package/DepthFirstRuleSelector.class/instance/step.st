evaluation
step
	"QUICK HACK TO MAKE CONFESS WORK"

	
	| currentFrame result |
	(currentFrame := callstack pop) isEmpty
		ifFalse:
			[self expandStack: (currentFrame resolveIn: env).
			^nil]
		ifTrue:
			[currentFrame rollback: env.
			result := currentFrame resultOf: vars in: env startAt: startedIndex.
			result == false ifTrue: [callstack push: currentFrame].
			^result]