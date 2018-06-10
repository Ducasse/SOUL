error handling
subscriptBoundsErrorFor: selector index: index value: aValue
	"This method is invoked when a subscript is an integer
	 but is out of range during an at:put:.  If the index is zero
	 assign the zero value, otherwise raise an error."

	
	index = 0 ifTrue: [^value0 := aValue].
	^super subscriptBoundsErrorFor: selector index: index value: aValue