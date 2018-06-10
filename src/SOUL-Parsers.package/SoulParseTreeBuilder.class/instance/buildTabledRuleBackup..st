SLG
buildTabledRuleBackup: aSoulRule
	
	| sequence |
	sequence := self buildProgramSequence: (self slgCallRuleFor: aSoulRule).
	sequence clauses addAll: (self slgImplementationRulesFor: aSoulRule).
	^sequence