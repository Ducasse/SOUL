resolving
smalltalkMessageResolveWithKnownReceiverIn: env startAt: anIndex receiver: receiver
	
	| arguments result |
	arguments := (termsequence terms allButFirst: 1) asArray
		collect: [:term | term soulDownIn: env startAt: anIndex].
	self verifyMessageToBeSentTo: receiver.
	result := receiver
		perform: functor messageSelector
		withArguments: arguments.
	self verifyResultIsBoolean: result.
	^result
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: env rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]