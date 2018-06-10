unification-transactions
rollbackTo: aRollBackInfo
	
	| newbindingIndex |
	newbindingIndex := aRollBackInfo at: 1.
	newbindingIndex
		to: bindingIndex - 1
		do:
			[:i | 
			variableArray
				at: (bindingArray at: i)
				put: nil].
	bindingIndex := newbindingIndex.
	variableIndex := aRollBackInfo at: 2