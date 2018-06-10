protocol support
allProtocols
	
	| collection |
	collection := Set new.
	collection addAll: self protocols.
	self subclasses do: [:class | collection addAll: class allProtocols].
	^collection