private
getStartWorld
	"I N C E P T I O N"
	startWorld ifNil: [
		startWorld := self termSequence terms first termSequence terms at: 2.	
	].
	^startWorld