building SOUL
buildRuleConclusion: aTerm condition: aTermSequence
	
	^(SoulFactory current makeRule condition: aTermSequence conclusion: aTerm)
		comment: self lastComments;
		yourself