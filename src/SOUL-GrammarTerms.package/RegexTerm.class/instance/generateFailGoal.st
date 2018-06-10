private
generateFailGoal
	
	| sequence |
	failGoal
		ifNil:
			[sequence := (SoulFactory current makeParser
				parse: ' if [ false ]'
				onError: [:a :b | self error: 'parse error in generated regexrule'])
				condition terms.
			failGoal := self generateGoal: sequence].
	^failGoal