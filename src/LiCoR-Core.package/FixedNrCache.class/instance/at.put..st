adding-removing
at: aKey put: anElement
	"add anElement, possibly after first removing another element (depending on the policy used)"

	
	self preAdd: anElement.
	self basicAt: aKey put: anElement