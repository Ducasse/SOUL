private
basicRemoveKey: aKey
	"remove aKey from the receiver. Assume it exists. Also remove it from the order"

	
	self elements removeKey: aKey.
	self order remove: aKey