template compilation
statementsUnderInterpretationXcompilesToXforResultXM4

<> statementsUnderInterpretation: ? compilesTo: <> forResult: ?.
<?firstTemplateStatement|?restTemplateStatements> statementsUnderInterpretation: ? compilesTo: <?firstTemplateStatement foundIn: ?statements withRest: ?restStatements|?query> forResult: ?statements if 
	not(?firstTemplateStatement equals: RBMessageNode(?,?,?args),?args contains: RBBlockNode(?,?)),?restStatements isNewQuotedVariable,?restTemplateStatements statementsUnderInterpretation: ? compilesTo: ?query forResult: ?restStatements.
"?args contains: RBBlockNode(?,?),"

<?firstTemplateStatement|?restTemplateStatements> statementsUnderInterpretation: ? compilesTo: <?firstTemplateStatement isMessageSendIn: ?statements withRest: ?restStatements|?query> forResult: ?statements if 
	?firstTemplateStatement equals: RBMessageNode(?,?,?args),?restStatements isNewQuotedVariable,?restTemplateStatements statementsUnderInterpretation: ? compilesTo: ?query forResult: ?restStatements.
?statements statementsUnderInterpretation: ? compilesTo: <?statements equals: ?statements2> forResult: ?statements2 if 
	?statements isQuotedVariable