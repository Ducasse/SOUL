adding-removing
remove: anElement
	"remove the element from the cache, if it exists. If it does not exist, do nothing"

	
	self removeKey: (self keyFor: anElement)