private
slgAnswerRuleWith: anInteger callTerm: resultTerm conditions: aTermCollection environmentVariables: vars
	
	| answer conditionVarString |
	conditionVarString := resultTerm functor asString = 'not'
		ifTrue: ['(?Id,' , vars asString , ',?D)']
		ifFalse: ['(?Id,' , vars asString , ',' , resultTerm asString , ',?D)'].
	answer := self conclusion.
	^self
		generateRule:
			(self generateContinuationHead: anInteger) , conditionVarString , ' if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					'answer(?Id,' , answer asString , ',?D)'
		onError: [:e :p | self halt]