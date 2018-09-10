prolog translation
testPrologTranslation
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