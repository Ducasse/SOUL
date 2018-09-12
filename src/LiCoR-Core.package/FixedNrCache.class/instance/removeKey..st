adding-removing
removeKey: aKey
	"remove the key from the cache, if it exists. If it does not exist, do nothing"

	
	(self includesKey: aKey) ifTrue: [self basicRemoveKey: aKey]