template compilation
templateUnderInterpretationXcompilesToXforResultXM4

RBMethodNode(?selector,?args,?templatebody) templateUnderInterpretation: ?interpretation compilesTo: <?result isMethodWithName: ?selector inClass: ?class,RBMethodNode(?selector,?args,?body) isParseTreeOfMethod: ?result|?bodyquery> forResult: ?result if 
	?result isNewQuotedVariable,?class isNewQuotedVariable,?body isNewQuotedVariable,?templatebody templateUnderInterpretation: ?interpretation compilesTo: ?bodyquery forResult: ?body.

RBSequenceNode(?templatetemps,?templatestatements) templateUnderInterpretation: ? compilesTo: <?result equals: RBSequenceNode(?temps,?statements),sublistOf(?templatetemps,?temps)|?statementsQuery> forResult: ?result if 
	?temps isNewQuotedVariable,?statements isNewQuotedVariable,?templatestatements statementsUnderInterpretation: ? compilesTo: ?statementsQuery forResult: ?statements