SLG
slgCallRuleFor: aSoulRule
	
	| literal |
	literal := aSoulRule conclusion printString.
	^(SoulFactory current makeParser
		parse: literal , ' if slg(' , literal , ')'
		onError: [:a :b | self error: 'Something went terribly wrong!']) clauses
		first asTabledRuleWithConditionString: aSoulRule condition displayString