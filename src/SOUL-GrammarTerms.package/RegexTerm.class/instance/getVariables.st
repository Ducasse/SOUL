private
getVariables
	"I N C E P T I O N"
	variablesVar ifNil: [
		variablesVar :=	self termSequence terms first termSequence terms at: 4
	].
	^variablesVar.