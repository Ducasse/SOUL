private
prepareForModifyingTermsequence
	"we save all the variables before modifying our own termsequence"
	self getEdgeTerm.
	self getEndWorld.
	self getPathVariable.
	self getResultVariable.
	self getStartWorld.
	self getVariables.