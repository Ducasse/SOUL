private
evalQuery: inQuery inEnv: anEnv startAt: anIndex
	"only to be used by the evaluator"

	
	| condition startframe failframe |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.
	vars := inQuery variables.
	env := anEnv.
	env callStack: callstack.
	condition := inQuery condition.
	startedIndex := anIndex.	"initialize the startframe with the conditions of the query"

	condition
		reverseDo:
			[:curCondition | startframe push: (TermPointer term: curCondition envIndex: anIndex)].
	failframe rollbackInfo: env rollbackInfo.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe