private
removeOldest
	"remove the oldest element added (this could mean different things according 
	to the policy of the cache)"

	"By default I take the oldest key (the first one added), and remove it and its 
	value from the cache"

	
	self basicRemoveKey: self order first