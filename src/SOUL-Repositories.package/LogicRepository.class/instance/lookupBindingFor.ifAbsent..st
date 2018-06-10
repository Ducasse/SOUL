repository composition
lookupBindingFor: aVariable ifAbsent: aBlock
	"Lookup the binding for a repository variable"

	
	^self
		lookupBindingForName: aVariable name
		ifAbsent: aBlock