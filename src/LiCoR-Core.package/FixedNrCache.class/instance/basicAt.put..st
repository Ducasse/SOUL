private
basicAt: aKey put: anElement
	"Add the element to the cache under the given key. Also keep track of the order 
	(add aKey to the end of order)"

	
	self elements at: aKey put: anElement.
	self order add: aKey