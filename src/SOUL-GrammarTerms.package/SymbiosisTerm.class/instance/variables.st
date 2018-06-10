access
variables
	"the internal representation of these variables is a collection with nil's on the first two places. They are used for evaluation purposes. This method returns the list of 	variables, to be used for (possible) external usage"

	
	^variables
		copyFrom: 3
		to: variables size