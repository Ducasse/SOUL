protocol support
classifyPredicate: key under: protocol ifAlreadyClassified: alreadyClassifiedBlock
	
	| current |
	current := self protocolOfPredicate: key.
	current
		ifNil: [self movePredicateKey: key toProtocol: protocol]
		ifNotNil:
			[current = protocol
				ifFalse:
					[(alreadyClassifiedBlock value: key value: current value: protocol)
						ifTrue: [self movePredicateKey: key toProtocol: protocol]]]