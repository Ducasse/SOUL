access
bind: aVariable to: aValue startAt: startIndex valueStartAt: valueStartIndex
	"This method adds ground variable bindings to the environment"

	
	| index nextIndex |
	index := startIndex + aVariable address.
	variableArray
		at: index
		put: (TermPointer term: aValue envIndex: valueStartIndex).
	nextIndex := self nextBindingIndex.
	bindingArray at: nextIndex put: index