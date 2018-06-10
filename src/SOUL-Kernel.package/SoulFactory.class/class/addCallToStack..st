SLG - auxiliary
addCallToStack: anSLGCall
	"returns the dfn (depth first number)"

	
	SLGCallStack add: anSLGCall.
	^SLGCallStack size