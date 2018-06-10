protocol support
protocolOfPredicate: aString
	
	| selector org |
	selector := self selectorForPredicateKey: aString.
	org := self organization.
	^org categoryOfElement: selector