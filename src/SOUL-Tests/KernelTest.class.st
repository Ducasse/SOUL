Class {
	#name : #KernelTest,
	#superclass : #LogicTests,
	#classVars : [
		'TestRepository'
	],
	#category : 'SOUL-Tests'
}

{ #category : #testRepository }
KernelTest class >> testRepository [
	
	^TestRepository
]

{ #category : #testRepository }
KernelTest class >> testRepository: aRep [
	
	TestRepository := aRep
]

{ #category : #private }
KernelTest >> assertExpressionPrintsAndParsesSanely: soulExpressionString [
	
	| representation |
	representation := SoulFactory current makeParser parse: soulExpressionString.
	self assertRepresentationPrintsAndParsesSanely: representation
]

{ #category : #private }
KernelTest >> assertRepresentationPrintsAndParsesSanely: representation [
	
	| printedExpressionString reparsedRepresentation reprintedExpressionString |
	printedExpressionString := representation printString.
	reparsedRepresentation := SoulFactory current makeParser parse:
			printedExpressionString.
	reprintedExpressionString := reparsedRepresentation printString.
	self assert: printedExpressionString = reprintedExpressionString
]

{ #category : #'parser-printer' }
KernelTest >> should: expression1 printAs: expression2 [
	
	| representation |
	representation := SoulFactory current makeParser parse: expression1.
	self assert: representation printString = expression2
]

{ #category : #'prolog translation' }
KernelTest >> should: soulString translateAs: prologString [
	
	| translated parsed |
	parsed := SoulParser parse: soulString.
	translated := parsed terms first asProlog.
	self
		assert: translated = (prologString , '.' , (String with: Character cr))
]

{ #category : #evaluator }
KernelTest >> testBasicRecursion [
	"self run:#testBasicRecursion"

	
	self repository assert: 'plus(pair(d,?x),?y,pair(d,?z)) if plus(?x,?y,?z)'.
	self repository assert: 'plus(zero,?x,?x)'.
	self
		processQuery: ' if plus(?x,?y,pair(d,pair(d,pair(d,zero))))'
		resultsCheck: [:results | results size = 4]
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,pair(d,pair(d,zero))),zero,pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,zero),pair(d,pair(d,zero)),pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,pair(d,zero)),pair(d,zero),pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self repository retractAll: 'plus/3'
]

{ #category : #symbiosis }
KernelTest >> testConstants [
	"self run:#testConstants"

	
	self processQuery: ' if succeeds(equals(a,[#a]))' description:
			'Testing shortcut notation for constant symbols.'.
	self processQuery: ' if succeeds(equals([#a],a))' description:
			'Testing shortcut notation for constant symbols.'.
	self processQuery: ' if succeeds(equals(1,[1]))' description:
			'Testing shortcut notation for constant integers.'.
	self processQuery: ' if succeeds(equals([1],1))' description:
			'Testing shortcut notation for constant integers.'.
	self processQuery: ' if fails(equals([Array],Array))' description:
			'Of course there is no shortcut notation for Smalltalk classes."'
]

{ #category : #'parser-printer' }
KernelTest >> testConversion [
	
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: #bar) smalltalkBlockString = 'bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: 'bar') smalltalkBlockString =
					'bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: '#bar') smalltalkBlockString =
					'#bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: #'instance creation')
				smalltalkBlockString = 'instance creation'
]

{ #category : #evaluator }
KernelTest >> testCut [
	"self run:#testCut"

	
	self repository assert:
			'foo(?x) if equals(a,?x),!.foo(?x) if equals(?x,b)'.
	self
		processQuery: ' if succeeds(foo(a))'
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if foo(?x)'
		resultsCheck: [:results | results size = 1]
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if succeeds(foo(b))'
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if member(?x,<1,2,3>),testcutonfinal(?c)'
		resultsCheck: [:results | results size = 9]
		description: 'Does the cut work when the last clause contains the cut?'.
	self repository retractAll: 'foo/1'
]

{ #category : #evaluator }
KernelTest >> testDynamicPredicate [
	"Test the dynamic predicate for failure"

	
	self
		processQuery: ' if fails(testDynamicPredicate)'
		description: 'Dynamic Predicate test'
		repository: self repository.	"Test a non-dynamic predicate for error"

	[self
		processQuery: ' if notTestDynamicPredicate'
		description: 'Dynamic Predicate test'
		repository: self repository]
		on: Error
		do: [:ex | true]
]

{ #category : #evaluator }
KernelTest >> testFactsInMultipleClasses [
	"self run:#testFactsInMultipleClasses"

	
	self
		processQuery: ' if fact3(?X)'
		resultsCheck: [:results | results size = 4]
		description:
			'Are all definitions of a predicate found when its definition is spread over multiple classes?'
]

{ #category : #evaluator }
KernelTest >> testList [
	"self run:#testList"

	
	self processQuery: ' if equals(<a,b,c>,<a,b,c>)' description:
			'Is the shorthand notation of list correct?'.
	self processQuery: ' if fails(equals(<a|b>,<a,b>))' description:
			'Is the cons-cel construction correct?'
]

{ #category : #evaluator }
KernelTest >> testListCollectionUnification [
	"self run:#testListCollectionUnification"

	
	self processQuery:
			' if equals(<a,b,c>,[OrderedCollection with: #a with: #b with: #c])'
		description: 'Do lists correctly unify with sequenceable collections?'.
	self processQuery:
			' if equals([OrderedCollection with: #a with: #b with: #c],<a,b,c>)'
		description: 'Do lists correctly unify with sequenceable collections?'.
	self processQuery: ' if equals(<>,[OrderedCollection new])' description:
			'Do empty lists correctly unify with empty sequenceable collections?'.
	self processQuery: ' if equals([OrderedCollection new],<>)' description:
			'Do empty lists correctly unify with empty sequenceable collections?'.
	self processQuery:
			' if equals([OrderedCollection
	with: #a
	with: (OrderedCollection with: #b)
	with: #c],<a,<b>,c>)' description: 'Do nested list unify?'.
	self processQuery:
			' if fails(equals([OrderedCollection with: #a with: #b],<a,b,c>))'
		description: 'Does unification fail when elements do not correspond?'.
	self processQuery:
			' if fails(equals([OrderedCollection with: #foo with: #bar],<a,b>))'
		description: 'Does unification fail when elements do not correspond?'
]

{ #category : #evaluator }
KernelTest >> testNegativeVariables [
	
	self processQuery: ' if testNegVariable(?a)' description:
			'The most simple case for negative variables'.
	self processQuery: ' if not(testNegVariable(a))' description:
			'The most simple case for negative variables'.
	self processQuery: ' if equals(?x,?a),testNegVariable(?x)' description:
			'The second simplest case for negative variables'.
	self processQuery: ' if equals(?x,a),not(testNegVariable(?x))'
		description: 'The second simplest case for negative variables'.
	self processQuery: ' if testNegVariable(2,?y),equals(?y,2)' description:
			'Do negative variables still work when used in a rule'
]

{ #category : #evaluator }
KernelTest >> testNestedFindall [
	
	self
		processQuery:
			' if findall(?xs,findall(?x,fooTest(?x),?xs),?ys),equals(?ys,<<1,2>>)'
		description: 'Nested findall test'
		repository: self repository
]

{ #category : #evaluator }
KernelTest >> testPositiveVariables [
	
	self repository assert: 'testPosVariable(+?x)'.
	self processQuery: ' if testPosVariable(a)' description:
			'The most simple case for positive variables'.
	self processQuery: ' if not(testPosVariable(?a))' description:
			'The most simple case for positive variables'.
	self processQuery: ' if equals(?x,a),testPosVariable(?x)' description:
			'The second simplest case for positive variables'.
	self processQuery:
			' if equals(?x,?y),not(testPosVariable(?x)),not(testPosVariable(?y))'
		description: 'The second simplest case for positive variables'.
	self processQuery: ' if equals(?x,a),equals(?x,?y),testPosVariable(?y)'
		description: 'The third simplest case for positive variables'.
	self repository retractAll: 'testPosVariable/1'.
	self repository assert: 'testing(2)'.
	self repository assert: 'testPosVariable(+?x) if testing(?x)'.
	self processQuery: ' if testPosVariable(2)' description:
			'Do positive variables still work when used in a rule'.
	self repository retractAll: 'testPosVariable/1'.
	self repository retractAll: 'testing/1'
]

{ #category : #'parser-printer' }
KernelTest >> testPrint [
	"This is a more strict test than the one performed by the sanity test testPrintAndParse. Unlike the sanity test, it really tests that the printer and parser are correct for these expressions and not just sane, but this test is sensitive to small changes in the printer (such as adding extra irrelevant spacing)"

	
	self should: '1' printAs: '1'.
	self should: 'abc' printAs: 'abc'.
	self should: '<1>' printAs: '<1>'.
	self should: '<?x>' printAs: '<?x>'.
	self should: '<1,2>' printAs: '<1,2>'.
	self should: '<1, 2>' printAs: '<1,2>'.
	self should: '< [1], [2] >' printAs: '<[1],[2]>'.
	self should: '<1,2|3>' printAs: '<1,2|3>'.
	self should: '<1,2|<3>>' printAs: '<1,2,3>'.
	self should: '<?x|?y>' printAs: '<?x|?y>'.
	self should: '<?x,?y>' printAs: '<?x,?y>'.
	self should: '<<?x>|<?y>>' printAs: '<<?x>,?y>'.
	self should: '<<?x>|?y>' printAs: '<<?x>|?y>'.
	self should: 'abc(1,2,3)' printAs: 'abc(1,2,3)'.
	self
		should: 'abc(1,xyz(2,2),3) if defg([#cat],[#dog]), hij([?x + ?y])'
		printAs:
			'abc(1,xyz(2,2),3) if '
				,
					(String
						with: Character cr
						with: Character tab) , 'defg([#cat],[#dog]),hij([?x + ?y])'
]

{ #category : #'parser-printer' }
KernelTest >> testPrintAndParse [
	"This does a sanity test of the printer and parser: the given expression is first parsed, and then printed. Then the printed version is again parsed and printed. The two prints should be exactly the same. Note that this is a necessary but not sufficient condition for the print to be correct, since printing everything to the string 'dummy' would also satisfy this test."

	
	self assertExpressionPrintsAndParsesSanely: 'abc'.
	self assertExpressionPrintsAndParsesSanely: '1'.
	self assertExpressionPrintsAndParsesSanely: '<>'.
	self assertExpressionPrintsAndParsesSanely: 'Abc'.
	self assertExpressionPrintsAndParsesSanely: '?x'.
	self assertExpressionPrintsAndParsesSanely: '[ 1 ]'.
	self assertExpressionPrintsAndParsesSanely: 'a(1,2)'.
	self assertExpressionPrintsAndParsesSanely: '[ 1 + ?x ]'.
	self assertExpressionPrintsAndParsesSanely: '<1,2,3>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2|3>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2,3|<>>'.
	self assertExpressionPrintsAndParsesSanely: '<1,2|<3>>'.
	self assertExpressionPrintsAndParsesSanely: '<?x|?y>'.
	self assertExpressionPrintsAndParsesSanely: '<?x|<?y>>'.
	self assertExpressionPrintsAndParsesSanely: 'a(1) if b(2)'.
	self assertExpressionPrintsAndParsesSanely:
			'a(1,2,3) if b(4,5,6), c(7,8,9)'.
	self assertExpressionPrintsAndParsesSanely:
			'a( 1, 2 ,3  ) if b( 4,5,6 ), c(7 , 8 , 9)'
]

{ #category : #'parser-printer' }
KernelTest >> testPrintAndParseExtensively [
	"This does the same sanity test as 'testPrintAndParse' but for all the clauses in LogicStorage."

	
	LogicStorage allClauses
		do: [:clause | self assertRepresentationPrintsAndParsesSanely: clause]
]

{ #category : #'prolog translation' }
KernelTest >> testPrologTranslation [
	"Check translation of variables"

	
	self should: '?x' translateAs: 'X'.
	self should: '?y' translateAs: 'Y'.
	self should: '?' translateAs: '_'.	"Check translation of simple values"

	self should: '1' translateAs: '1'.
	self should: '#bla' translateAs: 'bla'.
	self should: 'bla' translateAs: 'bla'.
	self should: 'Bla' translateAs: '''Bla'''.	"Check translation of compounds in old syntax"

	self should: 'bla(blie,bloe)' translateAs: 'bla(blie,bloe)'.
	self should: 'bla(?x,bloe(1))' translateAs: 'bla(X,bloe(1))'.	"Check translation of lists"

	self should: '<1,2,3>' translateAs: '[1,2,3]'.	" self should: '<1,2|X>' translateAs: '[1,2|X]'. " 	"FAILS, SHOULD BE FIXED"
	"Check translation of compounds in new syntax"

	self should: 'bla: ?x bloe: ?y' translateAs: 'bla_bloe(X,Y)'.
	self should: '?x bla' translateAs: 'bla(X)'.	"Check translation of rules"

	self should: 'bla(?x) if bloe(?y)' translateAs:
			'bla(X) :- 
	bloe(Y)'
]

{ #category : #evaluator }
KernelTest >> testQuotedCode [
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
	
	
]

{ #category : #repositories }
KernelTest >> testScoping [
	
	| repA repB |
	repA := SoulFactory current makeRepository new.
	repA compilationFactory: (SoulFactory current).
	repB := SoulFactory current makeRepository new.
	repB compilationFactory: (SoulFactory current).
	repA assert: 'fact(a)'.
	repA assert: 'equals(?x,?x)'.
	repA assert: '?b->fact(c)'.
	repA assert: '?b->fact(d) if fact(a)'.
	repB assert: 'fact(b)'.
	repA
		bind: (Variable name: 'b')
		with: repB.
	self processQuery: ' if fact(?x),equals(?x,a)' description:
			'Does the repository with bindings work as normal?' repository: repA.
	self processQuery: ' if ?b->fact(?x),equals(?x,b)' description:
			'Does the repository lookup work correctly?' repository: repA.
	self processQuery: ' if ?b->fact(d)' description:
			'Does the repository lookup work correctly?' repository: repA.
	self processQuery: ' if fact(b),fact(c)' description:
			'Does the repository addition work correctly?' repository: repB.
	self class testRepository: repB.
	[self processQuery:
			' if equals(?rep,[KernelTest testRepository]),?rep->fact(b)'
		description:
			'Does the lookup mechanism first consider looking in the local environment?'
		repository: repA] ensure: [self class testRepository: nil]
]

{ #category : #'parser-printer' }
KernelTest >> testSmalltalkTerms [
	
	self processQuery: ' if equals([''Is this ok? yeah!''],?x)' description:
			'Can Smalltalkterms contain question marks and not recognize them as variables?'
]

{ #category : #evaluator }
KernelTest >> testUnboundLookupLoop [
	"self run:#testUnboundLookupLoop"

	
	self processQuery: ' if succeeds(equals(?x,?x))' description:
			'Unbound variable lookup-loop test'
]

{ #category : #evaluator }
KernelTest >> testVarArgsCompoundWithMessageFunctors [
	
	self
		processQuery: ' if equals(#foo:@(?args), ?x foo: ?y)'
		description:
			'Binary message functors unify with variable argument compound terms (direct functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: #foo:,equals(?functor@(?args),?x foo: ?y)'
		description:
			'Binary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: #foo:bar:,equals(?functor@(?args),?x foo: ?y bar: ?z)'
		description:
			'Non-unary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository.
	self
		processQuery: ' if equals(isFoo@(?args),?x isFoo)'
		description:
			'Unary message functors unify with variable argument compound terms (direct functor symbol).'
		repository: self repository.
	self
		processQuery:
			' if ?functor equals: isFoo,equals(?functor@(?args),?x isFoo)'
		description:
			'Unary message functors unify with variable argument compound terms (indirect functor symbol).'
		repository: self repository
]

{ #category : #evaluator }
KernelTest >> testVariableFunctor [
	
	self repository assert: 'foo(?functor(?functor))'.
	self repository assert: 'bla(a)'.
	self
		processQuery: ' if succeeds(foo(bla(bla)))'
		description: 'Variable functor test'
		repository: self repository.
	self
		processQuery: ' if succeeds(and(equals(?name,bla),?name(a)))'
		description: 'Variable functor test'
		repository: self repository.
	self repository retractAll: 'bla/1'.
	self repository retractAll: 'foo/1'
]

{ #category : #evaluator }
KernelTest >> testVariablesAsConditions [
	
	self processQuery: ' if equals(?y,5),equals(?x,equals(?y,5)),?x'
		description:
			'Basic test to verify that variables can be used as conditions.'.
	self processQuery: ' if metaFact(?fact),?fact' description:
			'Test to verify that a variable can be used as condition when bound to a term coming from a fact.'.
	self processQuery: ' if and(equals(?x,equals(?y,6)),?x)' description:
			'Test to verify if using variables as conditions works in meta predicates such as "and" as well.'	"TODO: This following test fails!"
	"	self processQuery: 'if succeeds(equals(?x,equals(?y,6)),?x)'
		description: 'Test to verify if using variables as conditions works in meta predicates such as succeeds as well.'."
]

{ #category : #natives }
KernelTest >> testclause [
	
	self processQuery: ' if clause(equals(?a,?b),?body),equals(?body,<>)'
		description: 'Does the clause predicate give an empty body for a fact?'.
	self processQuery: ' if clause(?head,<>),equals(?head,equals(?z,?z))'
		description: 'Is equals(?z,?z) one of the facts in the repository?'.
	self processQuery:
			' if clause(?head,<not(equals(?a,?b))>),equals(?head,differs(?a,?b))'
		description:
			'Is the rule with the body not(equals(?a, ?b)) the one for the predicate differs?'.
	self processQuery:
			' if clause(equals(?avar,[?unboundVar someMessage]),?body)' description:
			'Does clause work correctly when the head contains a compound term with a smalltalk term in it?'
]

{ #category : #natives }
KernelTest >> testenvLookup [
	
	self processQuery:
			' if envLookup(?var,?result),equals([?result term],?var),equals([?result envIndex],1)'
		description:
			'Does envLookup return the termApp object for a variable correctly?'.
	self processQuery:
			' if envLookup(const,?result),equals([?result term name],const),equals([?result envIndex],1)'
		description:
			'Does envLookup return the termApp object for a constant correctly?'
]

{ #category : #natives }
KernelTest >> testgetEnv [
	
	self processQuery:
			' if getEnv(?env,?id),[(?env isKindOf: Environment) and: [?id isKindOf: Number]]'
		description: 'Does the getEnv predicate return an environment?'.
	self processQuery: ' if getEnv(?env,?id),[?env == env]' description:
			'Does the getEnv predicate return the correct environment?'
]

{ #category : #natives }
KernelTest >> testgetRepository [
	
	self processQuery:
			' if getRepository(?rep),[?rep isKindOf: LogicRepository]' description:
			'Does the getRepository predicate return a repository?'
]

{ #category : #evaluator }
KernelTest >> testnot [
	"not/1"

	
	self processQuery: ' if succeeds(not(list([1])))' description:
			'Does not/1 succeed when the enclosed query fails?'.
	self processQuery: ' if fails(not(list(<>)))' description:
			'Does fails/1 fail when the enclosed query succeeds?'.
	self processQuery: ' if succeeds(not(not(list(<>))))' description:
			'Does negation of negation succeed when the enclosed query fails?'.
	self processQuery: ' if fails(not(not(list([1]))))' description:
			'Does negation of negation fail when the enclosed query fails?'
]
