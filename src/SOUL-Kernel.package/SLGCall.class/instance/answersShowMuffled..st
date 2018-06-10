accessing
answersShowMuffled: aBoolean
	
	| delayed accept |
	^(answers
		reject:
			[:answer | 
			delayed := answer at: 2.
			accept := (delayed at: 1) isEmpty and: [(delayed at: 2) isEmpty].
			aBoolean
				ifTrue:
					[accept
						ifFalse:
							[Transcript
								show:
									'muffling answer: ' , (answer at: 1) asString , ' ' , delayed asString.
							Transcript cr]].
			accept not]) collect: [:answer | answer at: 1]