SLG
bridgeEndRuleWith: anInteger callTerm: resultTerm conditions: aTermCollection continuationString: aString vars: vars
	
	| conditionVarString |
	conditionVarString := '(?Id, vars asString,' , resultTerm asString ,
			', ?D, ?Cont)'.
	^self
		generateRule:
			self predicate , 'bridge' , anInteger asString , conditionVarString ,
					' if '
				,
					(aTermCollection isEmpty
						ifTrue: ['']
						ifFalse: [(TermSequence terms: aTermCollection) printString , ',']) ,
					aString
		onError: [:e :p | self halt]