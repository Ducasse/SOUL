protocol support
removeProtocol: protocolName
	
	(self predicateKeysIn: protocolName asSymbol)
		do: [:predicateKey | self retractClausesWithPredicateKey: predicateKey].
	self organization removeCategory: protocolName asSymbol