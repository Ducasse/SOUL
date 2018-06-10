evaluation
evalQuery: inQuery
	"build the first workframe, the failframe and the callstack"

	
	| condition startframe failframe |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.
	env := SoulFactory current makeEnvironment new.
	inQuery makeClean.
	inQuery accept: (LexicalAddressVisitor on: inQuery definitionRepository).
	vars := inQuery variables.
	env callStack: callstack.
	condition := inQuery condition.
	startedIndex := env currentVariableIndex.	"initialize the startframe with the conditions of the query"

	condition
		reverseDo:
			[:curCondition | 
			startframe
				push:
					(TermPointer
						term: curCondition
						envIndex: env currentVariableIndex)].
	failframe rollbackInfo: env rollbackInfo.
	env startUnifyWith: inQuery.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe