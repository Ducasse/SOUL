evaluator
testQuotedCode
	"TODO: (KG) I disabled these tests because they cause parsing errors with the LogicTestsRewriterVisitor"

	"self repository assert: 'quotedCodeTest1({a}).quotedCodeTest2({b}).quotedCodeTest3({})'.
	self
		processQuery: 'if succeeds(quotedCodeTest1({a}))'
		description: 'Does QuotedCode unify?'
		repository: self repository.
	self
		processQuery: 'if quotedCodeTest1(?a),quotedCodeTest2(?b),quotedCodeTest3(?c),succeeds(equals({a b},{?a ?b?c}))'
		description: 'Does QuotedCode substitute correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?x,bla),succeeds(equals({bla},{?x}))'
		description: 'Do constants in QuotedCode substitute correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?x,{bla foo}),[?x asString = ''bla foo'']'
		description: 'Are quotedcodes downed correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?x,{''bla'' is bla}),[?x asString = ('''''''',''bla'','''''''','' is bla'')]'
		description: 'Do quotes in QuotedCode substitute correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?x,[Object]),succeeds(equals({Object},{?x}))'
		description: 'Do smalltalkvalues in QuotedCode substitute correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?func(?c),{a ?b c}),length(?func,5)'
		description: 'Do Compoundterms and QuotedCode unify correctly?'
		repository: self repository.
	self
		processQuery: 'if equals(?x(?y),{a ?b c}),equals({a b c},{@?x({b})})'
		description: 'Do Compoundterms substitute correctly in QuotedCode?'
		repository: self repository.
	self repository retractall: 'quotedCodeTest1/1'."
	
	