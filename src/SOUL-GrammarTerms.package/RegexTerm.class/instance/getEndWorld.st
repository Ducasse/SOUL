private
getEndWorld
	"I N C E P T I O N"
	endWorld ifNil: [
		endWorld := self termSequence terms first termSequence terms at: 3	
	].
	^endWorld.
	
	