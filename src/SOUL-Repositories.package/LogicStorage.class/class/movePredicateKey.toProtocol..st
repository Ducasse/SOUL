protocol support
movePredicateKey: key toProtocol: protocol
	"returns true if successful, to see if we need to refresh any views"

	
	| selector org oldProtocol |
	selector := self selectorForPredicateKey: key.
	org := self organization.	"The below code is cleaner, but Store does not notice anything has changed when we do this."
	"TODO: Make the store notice!"

	org := self organization.
	oldProtocol := org categoryOfElement: selector.
	oldProtocol = protocol
		ifFalse:
			[org removeElement: selector.
			org classify: selector under: protocol.
			^true].
	^false