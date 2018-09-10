iterators
findallM3

"tested on 09-07-2001"

findall(&term,&query,?list) if 
	getEnv(?env,?envIdx),envLookup(&query,?queryPointer),envLookup(&term,?termPointer),deify(?list,[| ruleSelector holdcallStack oldFrame results hisIndex copier |
ruleSelector := SoulFactory current makeRuleSelector new.
holdcallStack := ?env callStack.
oldFrame := ?env currentFrame.
ruleSelector evalTermApplication: ?queryPointer inEnv: ?env.
results := OrderedCollection new.
[ruleSelector next == false]
	whileFalse:
		[results
			add:
				(?termPointer term soulUp
					soulDownIn: ?env
					startAt: ?termPointer envIndex) soulUp].
?env callStack: holdcallStack.
?env currentFrame: oldFrame.
copier := CopyingVisitor new.
(SoulFactory current makeList termSequence: (TermSequence terms: results))
	accept: copier])