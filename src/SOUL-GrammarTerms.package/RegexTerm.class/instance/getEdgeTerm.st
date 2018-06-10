private
getEdgeTerm
	"I N C E P T I O N"
	edgeTerm ifNil: [
		edgeTerm := self termSequence terms first termSequence terms first
	].
	^edgeTerm.