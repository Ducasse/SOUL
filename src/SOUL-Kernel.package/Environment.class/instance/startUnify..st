unification-transactions
startUnify: aNumber
	
	bindingRollbackIndex := bindingIndex.
	variableRollbackIndex := variableIndex.
	variableIndex + aNumber > variableMax
		ifTrue: [self resizeVariables: variableMax - variableIndex + aNumber].
	variableIndex := variableIndex + aNumber.
	^variableRollbackIndex