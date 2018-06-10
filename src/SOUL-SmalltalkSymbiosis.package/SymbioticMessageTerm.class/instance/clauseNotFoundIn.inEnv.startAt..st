resolving
clauseNotFoundIn: repository inEnv: env startAt: anIndex
	
	| resolveBlock |
	resolveBlock := [:uselessArg | 
	| receiver |
	receiver := termsequence terms first soulDownIn: env startAt: anIndex.
	(receiver isKindOf: Variable)
		ifTrue:
			[self smalltalkMessageResolveWithUnknownReceiverIn: env startAt: anIndex]
		ifFalse:
			[self smalltalkMessageResolveWithKnownReceiverIn: env startAt: anIndex
				receiver: receiver]].
	^NativeResolver onBlock: resolveBlock withArguments: #(#(nil))