instance creation
identifierToken: anIdentifierToken
	"Explicitly override this method for compatibility in Squeak. The Squeak version of RBVariableNode>>identifierToken explicitly makes either an instance of RBPatternVariableNode or an instance of RBVariableNode."

	
	^self new identifierToken: anIdentifierToken