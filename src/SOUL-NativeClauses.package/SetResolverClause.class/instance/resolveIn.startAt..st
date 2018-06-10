resolving
resolveIn: env startAt: anIndex
	
	| args block |
	block := self blockIn: env startAt: anIndex.
	args := self argsIn: env startAt: anIndex.
	^NativeResolver onBlock: block withArguments: args