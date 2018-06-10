initialize
withResolver: aResolver clauses: aStack rollbackInfo: aRollbackInfo cuttop: aState
	
	conditionsList := aStack.
	resolver := aResolver.
	self rollbackInfo: aRollbackInfo.
	cuttop := aState