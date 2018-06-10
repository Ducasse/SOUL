access
resultOf: vars in: env startAt: startIndex
	
	| return |
	return := vars
		collect:
			[:var | 
			(var isKindOf: DelayedVariable)
				ifTrue:
					[Binding
						var: var
						value: (var transitiveLookupIn: env startAt: startIndex) soulUp]
				ifFalse:
					[Binding
						var: var
						value: (var soulDownIn: env startAt: startIndex) soulUp]].
	^return