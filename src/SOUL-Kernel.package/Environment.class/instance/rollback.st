unification-transactions
rollback
	
	(bindingRollbackIndex to: bindingIndex - 1)
		do:
			[:i | 
			variableArray
				at: (bindingArray at: i)
				put: nil].
	bindingIndex := bindingRollbackIndex.
	variableIndex := variableRollbackIndex