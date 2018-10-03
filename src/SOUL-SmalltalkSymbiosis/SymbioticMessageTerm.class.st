Class {
	#name : #SymbioticMessageTerm,
	#superclass : #MessageTerm,
	#category : 'SOUL-SmalltalkSymbiosis'
}

{ #category : #resolving }
SymbioticMessageTerm >> clauseNotFoundIn: repository inEnv: env startAt: anIndex [
	
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
]

{ #category : #resolving }
SymbioticMessageTerm >> smalltalkMessageResolveWithKnownReceiverIn: env startAt: anIndex receiver: receiver [
	
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
]

{ #category : #resolving }
SymbioticMessageTerm >> smalltalkMessageResolveWithUnknownReceiverIn: env startAt: anIndex [
	
	self halt.
	self notYetImplemented
]

{ #category : #resolving }
SymbioticMessageTerm >> verifyMessageToBeSentTo: receiver [
	
	(receiver class canUnderstand: functor messageSelector)
		ifFalse:
			[self
				error:
					functor asString ,
							' is not implemented as a rule nor is understood as a message by instances of '
						, receiver class name asString]
]

{ #category : #resolving }
SymbioticMessageTerm >> verifyResultIsBoolean: result [
	
	(result isKindOf: Boolean) 
		ifFalse:
			[self
				error:
					'predicate ' , functor asString ,
							' was sent as a message but answer was not a boolean']
]
