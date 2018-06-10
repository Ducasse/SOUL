private
getPathVariable 
	"I N C E P T I O N"
	pathVar ifNil: [ 
		pathVar := self termSequence terms first termSequence terms at: 5
	].
	^pathVar.