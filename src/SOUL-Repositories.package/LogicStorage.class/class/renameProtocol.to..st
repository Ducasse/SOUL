protocol support
renameProtocol: oldName to: newName
	"asSymbol just to be sure"

	
	self organization
		renameCategory: oldName asSymbol
		to: newName asSymbol