private
removeFor: anElement
	"called if it is necessary to make room for a new elements that is going to be 
	added. Do not do an empty check, because the elements are not empty (or 
	this method would not have been called)"

	
	self removeOldest