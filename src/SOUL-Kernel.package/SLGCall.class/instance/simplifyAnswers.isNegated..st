private
simplifyAnswers: anSLGCall isNegated: aBoolean
	
	| delayed positive negative |
	answers copy
		do:
			[:answer | 
			delayed := answer at: 2.
			positive := delayed at: 1.
			negative := delayed at: 2.
			aBoolean
				ifTrue:
					["we are waiting on not(anSLGCall)"

					anSLGCall unfilteredAnswers isEmpty
						ifTrue:
							["this call has no answers, so we can remove this"

							negative := negative reject: [:x | x = anSLGCall]	"negative remove: anSLGCall."
]
						ifFalse:
							[anSLGCall answers isEmpty
								ifFalse:
									["we have a real answer, so our answer is incorrect"

									answers remove: answer]]]
				ifFalse:
					["we are waiting on anSLGCall"

					anSLGCall unfilteredAnswers isEmpty
						ifTrue:
							["SLGCall has no solutions, remove answer"

							answers remove: answer]
						ifFalse:
							[anSLGCall answers isEmpty
								ifFalse:
									["we have a real answer, so remove delayed literal"

									positive remove: anSLGCall]]]]