Logic Timer
logicTimer
	"Return the current tmer being used."

	
	LogicTimer isNil ifTrue: [self initializeLogicTimer].
	^LogicTimer