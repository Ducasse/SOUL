private
evalTermApplication: aTermApplication inEnv: anEnv
	"only to be used by the evaluator"

	
	| startframe failframe conditions query |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.	"change the below to avoid making a query"

	conditions := OrderedCollection new.
	conditions add: aTermApplication term.
	query := SoulFactory current makeQuery
		condition: (SoulFactory current makeTermSequence terms: conditions).
	vars := query variables.
	env := anEnv.
	env callStack: callstack.
	startedIndex := aTermApplication envIndex.	"initialize the startframe with the conditions of the query"

	startframe push: aTermApplication.
	failframe rollbackInfo: env rollbackInfo.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe