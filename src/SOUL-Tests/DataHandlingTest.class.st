Class {
	#name : #DataHandlingTest,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #'list handling' }
DataHandlingTest >> testappend [
	"self run:#testappend"

	
	self processQuery:
			' if succeeds(and(append(<[1],[2],[3]>,<[4],[5],[6]>,?r),equals(?r,<[1],[2],[3],[4],[5],[6]>)))'
		description: 'Can we append two simple lists?'.
	self processQuery:
			' if succeeds(append(<[1],[2],[3]>,<[4],[5],[6]>,<[1],[2],[3],[4],[5],[6]>))'
		description: 'Is the append of two simple lists the appended list?'.
	self processQuery:
			' if succeeds(and(append(<[1],[2],[3]>,?S,<[1],[2],[3],[4],[5],[6]>),equals(?S,<[4],[5],[6]>)))'
		description:
			'Can we deduce what second string needs be appended to a first one to get a certain result?'.
	self processQuery:
			' if succeeds(and(append(?F,<[3],[4],[5],[6]>,<[1],[2],[3],[4],[5],[6]>),equals(?S,<[1],[2]>)))'
		description:
			'Can we deduce what first string needs be appended to a second one to get a certain result?'.
	self processQuery:
			' if findall(?F,append(?F,?S,<[1],[2],[3],[4]>),<<>,<[1]>,<[1],[2]>,<[1],[2],[3]>,<[1],[2],[3],[4]>>)'
		description:
			'What possible strings can be appended to get a certain result string?'
]

{ #category : #'string handling' }
DataHandlingTest >> testappendAtoms [
	"self run:#testappendAtoms"

	"appendAtoms/3"

	
	self processQuery: ' if succeeds(appendAtoms(a,b,ab))' description:
			'Does appendAtoms/3 work correctly with 3 instantiated arguments?'.
	self processQuery: ' if succeeds(and(appendAtoms(a,b,?c),equals(?c,ab)))'
		description:
			'Does appendAtoms/3 work correctly with only first 2 arguments instantiated?'.
	self processQuery: ' if succeeds(appendAtoms([''a''],[''b''],[#ab]))'
		description:
			'The two first arguments may be strings, but the third is always a symbol.'.
	self processQuery:
			' if succeeds(and(appendAtoms([''a''],[''b''],?c),equals(?c,ab)))'
		description:
			'The two first arguments may be strings, but the third is always a symbol.'	"TODO: Diabled the tests below because in Squeak 'ab' = #'ab' is true, hence strings and symbols unify and the tests below fail. Should we fix the tests or the behavior of the predicate on Squeak? Fixing the behavior might be better as there is now the strange situation that the predicate can be true when the last argument is a string, but if the last argument is left unbound, no string will be given as a solution."
	"
	self	processQuery: 'if fails(appendAtoms([''a''],[''b''],[''ab'']))'
		description: 'As the third is assumed to be a symbol, the predicate will fail when it is a string.'.

	self	processQuery: 'if fails(and(appendAtoms([''a''],[''b''],?c),equals(?c,[''ab''])))'
		description: 'As the third is assumed to be a symbol, the predicate will fail when it is a string.'.
"
]

{ #category : #'the clause database' }
DataHandlingTest >> testassert1 [
	"self run:#testassert1"

	
	self processQuery: ' if assert(foo(foo(blabla))),foo(foo(blabla))'
		description: 'Does assert work properly for simple facts?'.
	self processQuery: ' if assert(foo([Object])),foo([Object])' description:
			'Does assert work properly for facts containing a simple smalltalkterm?'.
	self processQuery: ' if equals(?x,[Class]),assert(foo(?x)),foo([Class])'
		description:
			'Does assert work properly for facts containing a smalltalkterm with variables?'.
	self repository retractAll: 'foo/1'	"What about using assert/1 on logic rules? Which format to use?"
]

{ #category : #'the clause database' }
DataHandlingTest >> testassert2 [
	"self run:#testassert2"

	
	self processQuery: ' if getRepository(?rep),assert(foo(x)),foo(x)'
		description:
			'Check if the assert can assert a clause in the repository when it is given as a parameter'.
	self repository retractAll: 'foo/1'
]

{ #category : #'term type checking' }
DataHandlingTest >> testatom [
	"self run:#testatom"

	"atom/1"

	
	self processQuery: ' if fails(atom(?X))' description:
			'Does atom/1 fail for a variable?'.
	self processQuery: ' if succeeds(atom(<>))' description:
			'Does atom/1 succeed for a non-variable such as an empty list?'.
	self processQuery: ' if fails(atom(<a,b,?x,d>))' description:
			'Does atom/1 fail for a list?'.
	self processQuery: ' if succeeds(atom(hallo))' description:
			'Does atom/1 succeed for a symbol?'.
	self processQuery: ' if succeeds(atom(5))' description:
			'Does atom/1 succeed for a number?'.
	self processQuery: ' if succeeds(atom([''hallo'']))' description:
			'Does atom/1 succeed for a string?'.
	self processQuery: ' if succeeds(atom([Object]))' description:
			'Does atom/1 succeed for a Smalltalk class?'.
	self processQuery: ' if fails(atom(hallo(foo,bar)))' description:
			'Does atom/1 fail for a compound term?'.
	self processQuery: ' if fails(atom(hallo(?X,bar)))' description:
			'Does atom/1 fail for a compound term containing a variable?'
]

{ #category : #'pattern matching' }
DataHandlingTest >> testatomToChars [
	"self run:#testatomToChars"

	
	self processQuery: ' if succeeds(atomToChars(hello,?x))' description:
			'Generate a list of characters from a given atom'.
	self processQuery:
			' if succeeds(atomToChars(hello,<[#h],[#e],[#l],[#l],[#o]>))'
		description:
			'I dont understand why this one gives an error. There is something weird going on here...'.
	self processQuery: ' if succeeds(atomToChars([#hello],?x))' description:
			'Generate a list of characters from a given atom'.
	self processQuery:
			' if succeeds(atomToChars(hello,<[#h],[#e],[#l],[#l],[#o]>))'
		description: 'Does this also work when all arguments are bound?'.
	self processQuery: ' if fails(atomToChars(?atom,?x))' description:
			'Predicate fails when ?atom is not bound'.
	self processQuery:
			' if fails(atomToChars(?atom,<[#h],[#e],[#l],[#l],[#o]>))' description:
			'Predicate fails when ?atom is not bound'
]

{ #category : #'term type checking' }
DataHandlingTest >> testcompound [
	"self run:#testcompound"

	
	self processQuery: ' if compound(woman(maria))' description:
			'A simple compound'.
	self processQuery: ' if compound(woman(?x))' description:
			'A compound with variables'.
	self processQuery: ' if compound(<a,b,c>)' description:
			'A lists is a compound'.
	self processQuery: ' if compound(<kim>)' description:
			'A cons-pair is also a compound'.
	self processQuery: ' if fails(compound(?X))' description:
			'A variable is not a compound'.
	self processQuery: ' if fails(compound(hallo))' description:
			'An atom is not a compound'.
	self processQuery: ' if fails(compound(<>))' description:
			'An empty list is not a compound'
]

{ #category : #'quoted term handling' }
DataHandlingTest >> testconcatQuotedTerms [
	"self run:#testconcatQuotedTerms"

	"concatQuotedTerms/3"

	
	self processQuery: ' if succeeds(concatQuotedTerms(<>,{ },{}))'
		description:
			'Is the empty list converted in an empty quoted code term (regardless of the separator)?'.
	self processQuery: ' if succeeds(concatQuotedTerms(<{foo}>,{ },{foo}))'
		description:
			'Is a single quoted code term converted into itself (regardless of the separator)?'.
	self processQuery:
			' if succeeds(and(concatQuotedTerms(<{foo},{bar}>,{ },?result),equals(?result,{foo bar})))'
		description:
			'Is a list of two quoted code terms converted into a quoted code term containing those two quoted code terms with a space in between (when the separator is a space)?'.
	self processQuery:
			' if succeeds(and(concatQuotedTerms(<{foo},{bar},{zork}>,{ },?result),equals(?result,{foo bar zork})))'
		description:
			'Is a list of three quoted code terms converted into a quoted code term containing those three quoted code terms with a space between each two (when the separator is a space)?'
]

{ #category : #'list handling' }
DataHandlingTest >> testdeepflatten [
	"deepflatten/2"

	
	self processQuery:
			' if succeeds(deepflatten(<<[1],<[2]>,[3]>,<<<[4]>,[5]>,[6]>>,<[1],[2],[3],[4],[5],[6]>))'
		description:
			'Can we test whether a shallow list is a flattened version of a deeply nested list?'.
	self processQuery:
			' if succeeds(and(deepflatten(<<[1],[2],[3]>,<[4],[5],[6]>>,?flatlist),equals(?flatlist,<[1],[2],[3],[4],[5],[6]>)))'
		description: 'Can we flatten a deeply nested list into a shallow one?'.
	self processQuery:
			' if succeeds(and(deepflatten(<<[1],<hallo,aloha>,[2],<>,[3]>,<[4],<>,[5],[6]>>,?flatlist),equals(?flatlist,<[1],hallo,aloha,[2],[3],[4],[5],[6]>)))'
		description:
			'Can we flatten a deeply nested list that contains empty sublists into a shallow one?'.
	self processQuery: ' if fails(deepflatten(?x,<a,b,c,d>))' description:
			'Does deepflatten/2 fail when the first argument is variable?'
]

{ #category : #'set handling operators' }
DataHandlingTest >> testdifference [
	"difference/3"

	
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))' description:
			'Can the difference between two sets be computed?'.
	self processQuery:
			' if succeeds(and(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x),equals(?x,<a,y,d>)))'
		description: 'Is the difference between two sets computed correctly?'.
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,<a,y,d>))'
		description: 'Is the difference between two sets computed correctly?'.
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<g,k,h,m,s>,<a,e,y,f,u,r,d>))'
		description: 'Computing a difference for an empty intersection.'
]

{ #category : #'term comparison and sorting' }
DataHandlingTest >> testdiffers [
	"differs/2"

	
	self processQuery: ' if fails(differs(?X,?Y))' description:
			'Are two unbound logic variables NOT different?'.
	self processQuery: ' if fails(differs([1],[1]))' description:
			'Are two equal integers not different?'.
	self processQuery: ' if succeeds(differs([1],[2]))' description:
			'Are two unequal integers different?'.
	self processQuery: ' if fails(differs([1],1))' description:
			'Are the Smalltalk integer 1 and logic constant 1 not different?'.
	self processQuery: ' if fails(differs([#test],test))' description:
			'Are a Smalltalk symbol and its corresponding logic term not different?'
]

{ #category : #'set handling checks' }
DataHandlingTest >> testdisjoint [
	"disjoint/2"

	
	self processQuery: ' if succeeds(disjoint(<a,b,c>,<d,g,f,h>))'
		description: 'Are two sets disjoint?'.
	self processQuery: ' if succeeds(disjoint(<>,<d,g,f,h>))' description:
			'Is the empty set disjoint with another one?'.
	self processQuery: ' if succeeds(disjoint(<a,b,c>,<>))' description:
			'Is a set disjoint with the empty set?'.
	self processQuery: ' if succeeds(disjoint(<>,<>))' description:
			'Are two empty sets disjoint?'.
	self processQuery: ' if fails(disjoint(<a,b,c>,<d,e,b,f>))' description:
			'Are two sets not disjoint?'
]

{ #category : #'list handling' }
DataHandlingTest >> testemptyList [
	"emptyList/1"

	
	self processQuery: ' if succeeds(emptyList(<>))' description:
			'Is <> the notation for an empty list?'.
	self processQuery: ' if fails(emptyList(<1,2,3>))' description:
			'Is <1,2,3> not an empty list?'.
	self processQuery: ' if succeeds(and(emptyList(?var),equals(?var,<>)))'
		description:
			'When calling emptyList with a variable, is the variable bound to <>?'.
	self processQuery:
			' if succeeds(and(equals(<a>,?x),equals(?x,<?y|?z>),emptyList(?z)))'
		description: 'Is the tail of a singleton-list empty?'
]

{ #category : #'string handling' }
DataHandlingTest >> testendsWith [
	"self run: #testendsWith"

	"endsWith/2"

	
	self processQuery: ' if succeeds(endsWith([''aTest''],[''est'']))'
		description: 'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith([''aTest''],st))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,[''Test'']))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,Test))' description:
			'Does a certain string end with a certain postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,aTest))' description:
			'Does a string have itself as postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,['''']))' description:
			'Does a certain string end with the empty postfix?'.
	self processQuery: ' if succeeds(endsWith(aTest,atest))' description:
			'Is the endsWith predicate case INsensitive?'.
	self processQuery: ' if succeeds(endsWith([''aTest''],[''atest'']))'
		description: 'Is the endsWith predicate case INsensitive?'
]

{ #category : #'term comparison and sorting' }
DataHandlingTest >> testequals [
	"equals/2"

	
	self processQuery: ' if succeeds(equals([#add:],[#add:]))' description:
			'Are two equal Smalltalk symbols the same?'.
	self processQuery: ' if succeeds(equals([#test],test))' description:
			'Are a Smalltalk symbol and its corresponding logic term equal?'.
	self processQuery: ' if succeeds(equals([1],[1.0]))' description:
			'Is the integer 1 equal to the real number 1.0?'.
	self processQuery: ' if succeeds(and(equals(?X,?Y),var(?X),var(?Y)))'
		description: 'Can a variable be unified with another variable?'.
	self processQuery:
			' if succeeds(and(equals(?X,?Y),equals(?X,1),equals(?Y,1)))'
		description:
			'After unifying two variables and assigning a value to one of them, does the other one automatically get bound to the same value?'.
	self processQuery: ' if succeeds(equals(?X,[#add:]))' description:
			'Can a variable be unified with a value?'.
	self processQuery: ' if succeeds(equals([#add:],?Y))' description:
			'Can a value be unified with a variable?'.
	self processQuery: ' if succeeds(equals([#add],add))' description:
			'Is a Smalltalk symbol equal to the corresponding logic constant?'.
	self processQuery: ' if succeeds(equals(add,add))' description:
			'Are two equal logic constants (symbols) unified?'.
	self processQuery: ' if succeeds(equals(1,1))' description:
			'Are two equal logic constants (integers) unified?'.
	self processQuery: ' if succeeds(equals([1],1))' description:
			'Is a Smalltalk integer equal to the corresponding logic constant?'.
	self processQuery: ' if succeeds(equals([1.0],1))' description:
			'Is a Smalltalk integer in real form equal to the corresponding logic constant?'.
	self processQuery: ' if fails(equals([#add:],[#add]))' description:
			'Are two different Smalltalk symbols unequal?'.
	self processQuery: ' if succeeds(equals(<kim,tom>,<kim,tom>))'
		description:
			'Are two equal lists equal unregarding their external representation?'.
	self processQuery: ' if fails(equals(<kim,tom>,<tom,kim>))' description:
			'Are two unequal lists with different representation unequal?'.
	self processQuery: ' if fails(equals(<kim,tom>,<tom,kim>))' description:
			'Are two unequal lists with same representation unequal?'.
	self processQuery:
			' if succeeds(and(equals(?X,<x,y,z,u,v>),equals(<x,y,z,u,v>,?X)))'
		description: 'Can a variable be unified with a list?'.
	self processQuery: ' if succeeds(equals(<x,y,z,u,v>,<x,y,z,u,v>))'
		description:
			'Is a list in shorthand notation equal to its expanded form?'
]

{ #category : #'term conversion' }
DataHandlingTest >> testequalsStructureList [
	"self run:#testequalsStructureList"

	"self debug:#testequalsStructureList"

	"equalsStructureList/2"

	
	self processQuery: ' if succeeds(equalsStructureList(foo(bar),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a fully instantiated compound term?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo(bar),?list),equals(?list,<foo,bar>)))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(bar),<foo,bar>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(?x),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a partially instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo(?x),<foo,?x>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a partially instantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(?x(?y),?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a fully uninstantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(?x(?y),<?x,?y>))'
		description:
			'Does equalsStructureList/2 produced the correct result when first argument is a fully uninstantiated compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo,?list))'
		description:
			'Does equalsStructureList/2 work when first argument is a non-compound term?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo,?list),equals(?list,<foo>)))'
		description:
			'Does equalsStructureList/2 produce the correct result when first argument is a non-compound term?'.
	self processQuery: ' if succeeds(equalsStructureList(foo,<foo>))'
		description:
			'Does equalsStructureList/2 produce the correct result when first argument is a non-compound term?'.
	self processQuery: ' if fails(equalsStructureList(?x,?l))' description:
			'Does equalsStructureList/2 fails when both arguments are variable?'.
	self processQuery: ' if fails(equalsStructureList(?x,<?x>))' description:
			'Does equalsStructureList/2 fails when both arguments are variable?'.
	self processQuery: ' if fails(equalsStructureList(foo(bar),<foo(bar)>))'
		description:
			'Does equalsStructureList/2 not allow compound terms as keys?'.
	self processQuery:
			' if succeeds(equalsStructureList(foo(bar(a),zork(2),flur(e)),<foo|?More>))'
		description: 'Check correctness of equalsStructureList/2'.
	self processQuery:
			' if succeeds(and(equalsStructureList(foo(bar(a),zork(2),flur(e)),<foo|?More>),equals(?More,<bar(a),zork(2),flur(e)>)))'
		description: 'Check correctness of equalsStructureList/2'.
	self processQuery: ' if succeeds(equalsStructureList(?term,<foo,bar>))'
		description:
			'Does equalsStructureList/2 work when second argument is list with two bound arguments?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(?term,<foo,bar>),equals(?term,foo(bar))))'
		description:
			'Does equalsStructureList/2 produce the correct result when second argument is list with two bound arguments?'.
	self processQuery:
			' if succeeds(and(equalsStructureList(?term,<foo,?y>),equals(?term,foo(?y))))'
		description: 'Check correctness of equalsStructureList/2'	"THESE CASES ARE NOT SUPPORTED YET...

	self	processQuery: 'if succeeds(and(equalsStructureList(?term,<?x,bar>),equals(?term,?x(bar))))'
		description: 'Check correctness of equalsStructureList/2'.

	self	processQuery: 'if succeeds(and(equalsStructureList(?term,<?x,?y>),equals(?term,?x(?y))))'
		description: 'Check correctness of equalsStructureList/2'
"
]

{ #category : #'list handling' }
DataHandlingTest >> testflatten [
	"flatten/2"

	
	self processQuery: ' if succeeds(flatten(<<1,2,3>,<4,5,6>>,?flatlist))'
		description: 'Can we computed the flattened version of a nested list?'.
	self processQuery:
			' if succeeds(flatten(<<1,2,3>,<4,5,6>>,<1,2,3,4,5,6>))' description:
			'Is the flattened version of a nested list computed correctly?'.
	self processQuery:
			' if succeeds(and(flatten(<<[1],[2],[3]>,<[4],[5],[6]>>,?flatlist),equals(?flatlist,<[1],[2],[3],[4],[5],[6]>)))'
		description:
			'Does flatten/2 work correctly with second argument unbound?'.
	self processQuery:
			' if succeeds(flatten(<<1,<2>,3>,<<<4>,5>,6>>,<1,<2>,3,<<4>,5>,6>))'
		description:
			'Is the flattened version of a nested list computed correctly when the list is
					more than one level deep?'.
	self processQuery:
			' if succeeds(flatten(<<1,2,3>,<>,<a,b>,<c>,<>>,<1,2,3,a,b,c>))'
		description:
			'Does flatten work correctly when the list to be flattened contain empty sublists?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testground [
	"self run:#testground"

	
	self processQuery: ' if fails(ground(?X))' description:
			'Is a variable not ground?'.
	self processQuery: ' if fails(ground(?))' description:
			'Is an unnamed variable not ground?'.
	self processQuery: ' if succeeds(ground(<>))' description:
			'Is an empty list ground?'.
	self processQuery: ' if fails(ground(<a,b,?x,d>))' description:
			'Is a list that contains a variable ground?'.
	self processQuery: ' if fails(ground(<a,b,?,d>))' description:
			'Is a list that contains an unnamed variable ground?'.
	self processQuery: ' if succeeds(ground(<a,b,c,d>))' description:
			'Is a fully instantiated list ground?'
]

{ #category : #'list handling' }
DataHandlingTest >> testhead [
	"head/2"

	
	self processQuery: ' if succeeds(head(a,<a,b,c>))' description:
			'Does head/2 work correctly?'.
	self processQuery: ' if succeeds(head(?x,<a,b,c>))' description:
			'Does head/2 work when first argument is unbound?'.
	self processQuery: ' if succeeds(and(head(?x,<a,b,c>),equals(?x,a)))'
		description: 'Does head/2 work correctly when first argument is unbound?'.
	self processQuery: ' if succeeds(head(a,<?x,b,c>))' description:
			'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if succeeds(and(head(a,<?x,b,c>),equals(?x,a)))'
		description:
			'Does head/2 work correctly when first element of list is variable?'.
	self processQuery: ' if succeeds(head(?y,<?x,b,c>))' description:
			'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if succeeds(and(head(?y,<?x,b,c>),equals(?x,?y)))'
		description: 'Does head/2 work when first element of list is variable?'.
	self processQuery: ' if fails(head(?x,<>))' description:
			'Does the empty list have no head?'
]

{ #category : #'set handling checks' }
DataHandlingTest >> testincludes [
	"includes/2"

	
	self processQuery: ' if succeeds(includes(c,<d,a,c,b,f>))' description:
			'Does a certain element belong to a set?'.
	self processQuery: ' if fails(includes(q,<d,a,c,b,f>))' description:
			'Does a certain element not belong to a set?'.
	self
		processQuery: ' if includes(?El,<d,a,c,b,f>)'
		resultsCheck: [:results | results size = 5]
		description: 'Find all elements that belong to some set'.
	self processQuery: ' if fails(includes(q,<>))' description:
			'Does a certain element not belong to the empty set?'.
	self processQuery: ' if fails(includes(?E,<>))' description:
			'Does nothing belong to the empty set?'
]

{ #category : #'set handling operators' }
DataHandlingTest >> testintersection [
	"intersection/3"

	
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))'
		description: 'Can the intersection of two sets be computed?'.
	self processQuery:
			' if succeeds(and(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x),equals(?x,<e,f,u,r>)))'
		description: 'Is the intersection of two sets computed correctly?'.
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,<e,f,u,r>))'
		description: 'Is the intersection of two sets computed correctly?'.
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<g,k,h,m,s>,<>))'
		description: 'Computing an empty intersection.'
]

{ #category : #'list handling' }
DataHandlingTest >> testintersectionLists [
	"self run:#testintersectionLists"

	"Wat zou hier het resultaat van moeten zijn ?!
		if intersectionLists(<<?a, ?b>,<?a, ?z>>, ?i)"

	
	self processQuery:
			' if succeeds(and(intersectionLists(<<[1],[2],[42]>,<[2],[3],[42]>,<[3],[4],[42]>>,?i),equals(?i,<[42]>)))'
		description: 'Can we find the intersection of three lists?'.
	self processQuery: ' if fails(intersectionLists(<<[1],[2]>,?V>,?i))'
		description:
			'Is it true that intersectionLists cannot contain variables as lists to intersect?'.
	self processQuery:
			' if fails(intersectionLists(<<[1],[2],[42]>,<[2],?,[42]>,<[3],[4],[42]>>,?i))'
		description:
			'Is it true that intersectionLists cannot even contain variables in the lists to intersect?'
]

{ #category : #'string handling' }
DataHandlingTest >> testistAsSeparatedString [
	"self run:#testlistAsSeparatedString"

	"listAsSeparatedString/3"

	
	self processQuery:
			' if succeeds(listAsSeparatedString(<>,['' ''],['''']))' description:
			'Is the empty list converted in an empty string (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo>,['' ''],[''foo'']))'
		description:
			'Is a single symbol converted into a string containing just that symbol (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar>,['' ''],[''foo bar'']))'
		description:
			'Is a list of two symbols converted into a list containing those two symbols with a space in between (when the separator is a space)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar,zork>,['' ''],[''foo bar zork'']))'
		description:
			'Is a list of three symbols converted into a list containing those three symbols with a space between each two symbols (when the separator is a space)?'
]

{ #category : #'list handling' }
DataHandlingTest >> testlength [
	"self run:#testlength"

	"This default test, which always fails, was generated automatically.
	 Please replace with an adequate test of predicate length!"

	
	self processQuery: ' if succeeds(length(<[1],[2],[3]>,3))' description:
			'checks whether the length of a list of length 3 is well-calculated'.
	self processQuery:
			' if succeeds(and(length(<[1],[2],[3]>,?x),equals(?x,3)))' description:
			'checks whether the length of a list of length 3 is well-calculated'.
	self processQuery: ' if succeeds(length(<>,0))' description:
			'has the empty list length 0?'.
	self processQuery: ' if length(?list,[5]),equals(?list,<?,?,?,?,?>)'
		description:
			'can the predicate be used to generate a list of a given length?'.
	self processQuery:
			' if not(succeeds(length(?l,3),equals(?l,<?x,?x,?x>),equals(?l,<1,2,3>)))'
		description: 'is the resulting list not filled with anonymous variables?'
]

{ #category : #'list handling' }
DataHandlingTest >> testlist [
	"list/1"

	
	self processQuery: ' if tail(?l,<[1]>),list(?l)' description:
			'Is the empty tail of a list a list ?'.
	self processQuery: ' if tail(?l,<[1],[2],[3]>),list(?l)' description:
			'Is the non-empty tail of a list a list ?'.
	self processQuery: ' if not(list(foo([2])))' description:
			'Is a compound term not a list ?'.
	self processQuery: ' if not(list(?v))' description:
			'Is an unbound variable not a list ?'
]

{ #category : #'string handling' }
DataHandlingTest >> testlistAsSeparatedString [
	"self run:#testlistAsSeparatedString"

	"listAsSeparatedString/3"

	
	self processQuery:
			' if succeeds(listAsSeparatedString(<>,['' ''],['''']))' description:
			'Is the empty list converted in an empty string (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo>,['' ''],[''foo'']))'
		description:
			'Is a single symbol converted into a string containing just that symbol (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar>,['' ''],[''foo bar'']))'
		description:
			'Is a list of two symbols converted into a list containing those two symbols with a space in between (when the separator is a space)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar,zork>,['' ''],[''foo bar zork'']))'
		description:
			'Is a list of three symbols converted into a list containing those three symbols with a space between each two symbols (when the separator is a space)?'
]

{ #category : #'string handling' }
DataHandlingTest >> testmakeFirstCapitalLowerCase [
	"self run: #testmakeFirstCapitalLowerCase"

	"makeFirstCapitalLowerCase/2"

	
	self processQuery:
			' if succeeds(makeFirstCapitalLowerCase([''Test''],[''test'']))'
		description: 'Transform first capital into lowercase'.
	self processQuery:
			' if succeeds(makeFirstCapitalLowerCase([''test''],[''test'']))'
		description: 'Does it work if first is already lowercase?'.
	self processQuery:
			' if succeeds(and(makeFirstCapitalLowerCase([''Test''],?x),equals(?x,[''test''])))'
		description: 'Does it work when second argument is variable?'
]

{ #category : #'list handling' }
DataHandlingTest >> testmember [
	"member/2"

	
	self processQuery: ' if succeeds(member(a,<a,b,c>))' description:
			'Does the list <a,b,c> contain a?'.
	self processQuery: ' if succeeds(member(b,<a,b,c>))' description:
			'Does the list <a,b,c> contain b?'.
	self processQuery: ' if fails(member(d,<a,b,c>))' description:
			'Does the list <a,b,c> not contain d?'.
	self processQuery: ' if succeeds(member(p(b),<p(a),q,3,p(b),p(b)>))'
		description: 'Does member/2 work for compound terms?'.
	self
		processQuery: ' if member(?X,<a,b,c>)'
		resultsCheck: [:results | results size = 3]
		description: 'Does the list <a,b,c> contain 3 elements?'.
	self
		processQuery: ' if member(?X,<a,?b,c>)'
		resultsCheck: [:results | results size = 3]
		description:
			'Does member work correctly with lists containing variables?'.
	self processQuery: ' if succeeds(member(a,?L))' description:
			'Does member/2 work when the list is variable?'.
	self processQuery: ' if succeeds(and(member(a,?L),equals(?L,<a|?Rest>)))'
		description:
			'When member/2 is called with a variable list, does it generate a list with the element in it?'.
	self
		processQuery: ' if member(p(?X),<p(a),p(b),p(c)>)'
		resultsCheck: [:results | results size = 3]
		description: 'Does the list <p(a),p(b),p(c)> contain 3 elements?'.
	self processQuery: ' if fails(member(?X,?L))' description:
			'Does the predicate fail when called with two variables?'
]

{ #category : #'list handling' }
DataHandlingTest >> testnoDups [
	"self run: #testnoDups"

	"self debug: #testnoDups"

	
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,c>,?nodups),sameElements(?nodups,<a,b,d,c>)))'
		description:
			'What is the non-duplicates list of a non-duplicates containing list?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,c>,<a,b,d,c>))'
		description:
			'Test the non-duplicates list of a non-duplicates containing list.'.
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,b,a,c,b,c>,?nodups),length(?nodups,4)))'
		description: 'Does noDups/2 actually remove duplicates?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,b,a,c,b,c>,<a,b,d,c>))'
		description:
			'Test the non-duplicates list of a list containing duplicates.'.
	self processQuery: ' if succeeds(noDups(<a,b,d,b,a,c,b,c>,<d,c,b,a>))'
		description:
			'Test the non-duplicates list of a list containing duplicates.'.
	self processQuery:
			' if succeeds(and(noDups(<a,b,d,b,a,c,c,c,b,a>,?nodups),sameElements(?nodups,<a,b,d,c>)))'
		description:
			'What is the non-duplicates list of a duplicates containing list?'.
	self processQuery: ' if succeeds(noDups(<a,b,d,c>,<c,b,a,d>))'
		description:
			'What is the list with duplicates for a result list containing no duplicates?'.
	self processQuery: ' if fails(noDups(?res,<c,b,a,d,c>))' description:
			'Does noDups/2 fail when first argument is uninstantiated?'.
	self processQuery: ' if succeeds(noDups(<[Array]>,?no))' description:
			'Does noDups/2 succeeds for <[Array]>?'
]

{ #category : #'list handling' }
DataHandlingTest >> testnonEmptyList [
	"nonEmptyList/1"

	
	self processQuery: ' if fails(nonEmptyList(<>))' description:
			'Is the empty list <> not non-empty?'.
	self processQuery: ' if succeeds(nonEmptyList(<a,b,c,b>))' description:
			'Is <a,b,c> a non-empty list?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testnonground [
	"nonground/1"

	
	self processQuery: ' if succeeds(nonground(?X))' description:
			'Is a variable not ground?'.
	self processQuery: ' if fails(nonground(<>))' description:
			'Is an empty list ground?'.
	self processQuery: ' if succeeds(nonground(<a,b,?x,d>))' description:
			'Is a list that contains a variable nonground?'.
	self processQuery: ' if fails(nonground(<a,b,c,d>))' description:
			'Is a fully instantiated list ground?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testnonvar [
	"nonvar/1"

	
	self processQuery: ' if fails(nonvar(?X))' description:
			'Does nonvar/1 fail for a variable?'.
	self processQuery: ' if succeeds(nonvar(<>))' description:
			'Does nonvar/1 succeed for a non variable such as an empty list?'.
	self processQuery: ' if succeeds(nonvar(<a,b,?x,d>))' description:
			'Does nonvar/1 succeed for a list (even when that list may contain variables)?'.
	self processQuery: ' if succeeds(nonvar(<a,b,c,d>))' description:
			'Does nonvar/1 succeed for a fully instantiated list?'.
	self processQuery: ' if succeeds(nonvar(hallo))' description:
			'Does nonvar/1 succeed for a symbol?'.
	self processQuery: ' if succeeds(nonvar(5))' description:
			'Does nonvar/1 succeed for a number?'.
	self processQuery: ' if succeeds(nonvar([TestClass1]))' description:
			'Does nonvar/1 succeed for a Smalltalk class?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testquotedCode [
	"self run: #testquotedCode"

	
	self processQuery: ' if quotedCode({a b c})' description:
			'Detect quotedcode as quotedcode?'.
	self processQuery: ' if not(quotedCode(foo))' description:
			'Fail if not quotedcode?'.
	self processQuery: ' if not(quotedCode(?x))' description:
			'Fail if not quotedcode?'
]

{ #category : #'list handling' }
DataHandlingTest >> testremove [
	"remove/3"

	
	self processQuery:
			' if succeeds(remove(<[1],[2],[3],[4],[5]>,[4],<[1],[2],[3],[5]>))'
		description: 'Remove an element from a list'.
	self processQuery: ' if succeeds(remove(<1,2,3,4,5>,4,?L))' description:
			'Remove an element from a list'.
	self processQuery:
			' if succeeds(and(remove(<1,2,3,4,5>,4,?L),equals(?L,<1,2,3,5>)))'
		description: 'Remove an element from a list'.
	self
		processQuery: ' if remove(<1,2,3,2,1>,1,?L)'
		resultsCheck: [:results | results size = 1]
		description: 'Only first occurence is removed'.
	self processQuery: ' if fails(remove(<1,2,3,2,1>,1,<1,2,3,2>))'
		description: 'Only first occurence is removed'.
	self processQuery: ' if succeeds(remove(<1,2,3,2,1>,?X,?L))' description:
			'Remove some element from some list.'.
	self processQuery: ' if succeeds(remove(?L,4,<a,b,c>))' description:
			'Remove can also be called with first argument variable.'.
	self
		processQuery: ' if remove(?L,4,<a,b,c>)'
		resultsCheck: [:results | results size = 4]
		description:
			'There are 4 ways to re-insert an element in a list of size 3'
]

{ #category : #'the clause database' }
DataHandlingTest >> testretract1 [
	"self run:#testretract1"

	
	self repository assert: 'testretract(a).testretract(b)'.
	self processQuery:
			' if retract(testretract(f)),exactlyOne(testretract(b))' description:
			'Is the first clause retracted correctly?'.
	self processQuery: ' if retract(testretract(b)),fails(testretract(b))'
		description: 'Is the second clause retracted correctly?'.
	self processQuery: ' if fails(retract(?foo))' description:
			'We cannot retract unground terms'
]

{ #category : #'the clause database' }
DataHandlingTest >> testretractall1 [
	"self run:#testretractall1"

	
	self repository assert: 'testretract2(a).testretract2(a)'.
	self processQuery:
			' if retractall(testretract2(a)),fails(testretract2(a))' description:
			'Are all clauses retracted correctly?'.
	self processQuery: ' if fails(retractall(?foo))' description:
			'We cannot retract unground terms'
]

{ #category : #'list handling' }
DataHandlingTest >> testreverse [
	"reverse/2"

	
	self processQuery:
			' if succeeds(reverse(<[4],[3],[2],[1]>,<[1],[2],[3],[4]>))'
		description:
			'Does reverse work correctly with two instantiated arguments?'.
	self processQuery: ' if succeeds(reverse(?L,<1,2,3,4>))' description:
			'Does reverse work with first argument unbound?'.
	self processQuery:
			' if succeeds(and(reverse(?L,<1,2,3,4>),equals(?L,<4,3,2,1>)))'
		description: 'Does reverse work correctly with first argument unbound?'.
	self processQuery: ' if succeeds(reverse(<1,2,3,4>,?L))' description:
			'Does reverse work with second argument unbound?'.
	self processQuery:
			' if succeeds(and(reverse(<1,2,3,4>,?L),equals(?L,<4,3,2,1>)))'
		description: 'Does reverse work correctly with second argument unbound?'
]

{ #category : #'list handling' }
DataHandlingTest >> testsameElements [
	"sameElements/2"

	
	self processQuery: ' if succeeds(sameElements(<>,<>))' description:
			'Has the empty list the same elements as the empty list?'.
	self processQuery: ' if succeeds(sameElements(<a,b,c,d>,<d,c,a,b>))'
		description: 'Are two lists of symbols with permuted elements the same?'.
	self processQuery: ' if sameElements(<1,2,3>,<2,1,3>)' description:
			'Are two lists of numbers with permuted elements the same?'.
	self processQuery:
			' if succeeds(sameElements(<[1],[2],[3]>,<[2],[1],[3]>))' description:
			'Are two lists of numbers with permuted elements the same?'.
	self processQuery: ' if fails(sameElements(<a,b,c>,<d,a,b>))' description:
			'Are two lists with different elements unequal?'
]

{ #category : #'string handling' }
DataHandlingTest >> teststartsAndEndsWith [
	"self run:#teststartsAndEndsWith"

	"startsAndEndsWith/3"

	
	self processQuery:
			' if succeeds(startsAndEndsWith([''aTest''],[''a''],[''Test'']))'
		description: 'Does a certain string start and end with given substrings?'.
	self processQuery:
			' if succeeds(startsAndEndsWith([''aTest''],[''a''],?End))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery:
			' if succeeds(and(startsAndEndsWith([''aTest''],[''a''],?End),equals(?End,[''Test''])))'
		description:
			'Does a certain string start with a certain prefix and is the
		remainder of the string computed correctly?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,aTes,?E))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,aTest,[#'''']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,[#''''],aTest))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsAndEndsWith(aTest,ate,?E))'
		description:
			'Is the startsAndEndsWith predicate case INsensitive on second argument?'.
	self processQuery: ' if fails(startsAndEndsWith(aTest,aTe,sT))'
		description:
			'Is the startsAndEndsWith predicate case SENSITIVE on third argument?'
]

{ #category : #'string handling' }
DataHandlingTest >> teststartsWith [
	"test run:#teststartsWith"

	"startsWith/2"

	
	self processQuery: ' if succeeds(startsWith([''aTest''],[''a'']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith([''aTest''],aT))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,[''aTe'']))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,aTes))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,aTest))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,['''']))' description:
			'Does a certain string start with a certain prefix?'.
	self processQuery: ' if succeeds(startsWith(aTest,atest))' description:
			'Is the startsWith predicate case INsensitive?'.
	self processQuery: ' if succeeds(startsWith([''aTest''],[''atest'']))'
		description: 'Is the startsWith predicate case INsensitive?'
]

{ #category : #'term type checking' }
DataHandlingTest >> teststring [
	"self run: #teststring"

	"string/1"

	
	self processQuery: ' if fails(string(?X))' description:
			'Is a variable not a string?'.
	self processQuery: ' if fails(string(1))' description:
			'Is a number not a string?'.
	self processQuery: ' if fails(string([Object]))' description:
			'Is a Smalltalk class not a string?'.
	self processQuery: ' if succeeds(string(hallo))' description:
			'Is a symbol a string?'.
	self processQuery: ' if succeeds(string([#hallo]))' description:
			'Is a Smalltalk symbol a string?'.
	self processQuery: ' if succeeds(string([''hello there'']))' description:
			'Is a Smalltalk string a string?'
]

{ #category : #'pattern matching' }
DataHandlingTest >> teststringOrAtom [
	"self run:#teststringOrAtom"

	
	self processQuery: ' if succeeds(stringOrAtom([''hallo'']))' description:
			'stringOrAtom succeeds when a string is given as input'.
	self processQuery: ' if succeeds(stringOrAtom(hallo))' description:
			'stringOrAtom succeeds when an atom is given as input'
]

{ #category : #'string handling' }
DataHandlingTest >> teststringOrAtomSplit [
	"self run:#teststringOrAtomSplit"

	"stringOrAtomSplit/4"

	
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,T,erDeTester))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,TesterDeT,er))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit(TesterDeTester,est,?Before,?After))'
		description:
			'Does stringOrAtomSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery: ' if stringOrAtomSplit(TesterDeTester,est,?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringOrAtomSplit/4 produce more than one result if necessary?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],[''T''],[''erDeTester'']))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],[''TesterDeT''],[''er'']))'
		description:
			'Does stringOrAtomSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringOrAtomSplit([''TesterDeTester''],[''est''],?Before,?After))'
		description:
			'Does stringOrAtomSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery:
			' if stringOrAtomSplit([''TesterDeTester''],[''est''],?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringOrAtomSplit/4 produce more than one result if necessary?'
]

{ #category : #'string handling' }
DataHandlingTest >> teststringOrAtomStartsWith [
	"self run:#teststringOrAtomStartsWith"

	"stringOrAtomStartsWith/2"

	
	self processQuery:
			' if succeeds(stringOrAtomStartsWith([''aTest''],[''a''],[''Test'']))'
		description: 'Does a certain string start and end with given substrings?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith([''aTest''],[''a''],?End))'
		description: 'Does a certain string start with a certain prefix?'.
	self processQuery:
			' if succeeds(and(stringOrAtomStartsWith([''aTest''],[''a''],?End),equals(?End,[''Test''])))'
		description:
			'Does a certain string start with a certain prefix and is the
		remainder of the string computed correctly?'.
	self processQuery: ' if succeeds(stringOrAtomStartsWith(aTest,aTes,?E))'
		description: 'Does a certain atom start with a certain atom as prefix?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith(aTest,aTest,[#'''']))' description:
			'Does a certain atom start with a certain atom as prefix?'.
	self processQuery:
			' if succeeds(stringOrAtomStartsWith(aTest,[#''''],aTest))' description:
			'Does a certain string or atom start with a certain prefix?'.
	self processQuery: ' if succeeds(stringOrAtomStartsWith(aTest,ate,?E))'
		description:
			'Is the stringOrAtomStartsWith predicate case INsensitive on second argument?'.
	self processQuery: ' if fails(stringOrAtomStartsWith(aTest,aTe,sT))'
		description:
			'Is the stringOrAtomStartsWith predicate case SENSITIVE on third argument?'
]

{ #category : #'pattern matching' }
DataHandlingTest >> teststringOrAtomToChars [
	"self run:#teststringOrAtomToChars"

	"This default test, which always fails, was generated automatically.
	 Please replace with an adequate test of predicate stringOrAtomToChars!"

	
	self processQuery:
			' if succeeds(stringOrAtomToChars([''hello''],<[#h],[#e],[#l],[#l],[#o]>))'
		description: 'to be tested'	"MORE TESTS NEED TO BE ADDED HERE!!!"
]

{ #category : #'string handling' }
DataHandlingTest >> teststringSplit [
	"self run:#teststringSplit"

	"stringSplit/4"

	
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],[''T''],[''erDeTester'']))'
		description:
			'Does stringSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],[''TesterDeT''],[''er'']))'
		description:
			'Does stringSplit/4 work correctly with 4 instantiated arguments?'.
	self processQuery:
			' if succeeds(stringSplit([''TesterDeTester''],[''est''],?Before,?After))'
		description:
			'Does stringSplit/4 work with last two arguments uninstantiated?'.
	self
		processQuery:
			' if stringSplit([''TesterDeTester''],[''est''],?Before,?After)'
		resultsCheck: [:results | results size = 2]
		description:
			'Does stringSplit/4 produce more than one result if necessary?'
]

{ #category : #'pattern matching' }
DataHandlingTest >> teststringToChars [
	"self run:#teststringToChars"

	
	self processQuery:
			' if succeeds(stringToChars([''hello''],<[#h],[#e],[#l],[#l],[#o]>))'
		description: 'to be tested'	"MORE TESTS NEED TO BE ADDED HERE!!!"
]

{ #category : #'set handling checks' }
DataHandlingTest >> testsubSet [
	"subSet/2"

	
	self processQuery: ' if succeeds(subSetOf(<a,b,c>,<d,a,c,b,f>))'
		description: 'Is a certain set a subset of another one?'.
	self processQuery: ' if fails(subSetOf(<a,b,q,c>,<d,a,c,b,f>))'
		description: 'Is a certain set no subset of another one?'.
	self processQuery: ' if succeeds(subSetOf(<>,<d,a,c,b,f>))' description:
			'Is the empty set a subset of another set?'.
	self processQuery: ' if succeeds(subSetOf(<>,<>))' description:
			'Is the empty set a subset of itself?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testsymbol [
	"self run: #testsymbol"

	"symbol/1"

	
	self processQuery: ' if fails(symbol(?X))' description:
			'Is a variable not a symbol?'.
	self processQuery: ' if fails(symbol(1))' description:
			'Is a number not a symbol?'.
	self processQuery: ' if fails(symbol([Object]))' description:
			'Is a Smalltalk class not a symbol?'.
	self processQuery: ' if succeeds(symbol(hallo))' description:
			'Check shortcut notation for symbol'.
	self processQuery: ' if succeeds(symbol([#hallo]))' description:
			'Is #hallo a symbol ?'.
	self processQuery: ' if fails(symbol([''hello there'']))' description:
			'Is a Smalltalk string not a symbol?'
]

{ #category : #'list handling' }
DataHandlingTest >> testtail [
	"tail/2"

	
	self processQuery: ' if succeeds(tail(<b,c>,<a,b,c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(<c>,<b,c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(<>,<c>))' description:
			'Does tail/2 work correctly?'.
	self processQuery: ' if succeeds(tail(?x,<a,b,c>))' description:
			'Does tail/2 work when first argument is unbound?'.
	self processQuery: ' if succeeds(and(tail(?x,<a,b,c>),equals(?x,<b,c>)))'
		description: 'Does tail/2 work correctly when first argument is unbound?'.
	self processQuery: ' if succeeds(tail(?x,<a|?y>))' description:
			'Does tail/2 work when rest of list is variable?'.
	self processQuery: ' if succeeds(and(tail(?x,<a|?y>),equals(?x,?y)))'
		description: 'Does tail/2 work correctly when rest of list is variable?'.
	self processQuery: ' if succeeds(tail(?x,<a|?x>))' description:
			'Does tail/2 work correctly when rest of list is variable?'.
	self processQuery: ' if fails(tail(?x,<>))' description:
			'Does the empty list have no tail?'
]

{ #category : #'set handling operators' }
DataHandlingTest >> testunion [
	"union/3"

	
	self processQuery: ' if succeeds(union(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))'
		description: 'Is it possible to compute the union of two sets?'.
	self processQuery:
			' if succeeds(union(<a,b,c,d>,<e,f,g,h>,<a,b,c,d,e,f,g,h>))'
		description: 'Is the union of two sets correctly computed?'.
	self processQuery:
			' if succeeds(union(<a,b,c,d>,<b,e,c,a,d>,<a,b,c,d,e>))' description:
			'Is the union of two sets correctly computed?'.
	self processQuery:
			' if succeeds(and(equals(?Set,<a,b,c,d>),union(?Set,<>,?Set)))'
		description: 'Is the union of a set with the empty set the same set?'.
	self processQuery:
			' if succeeds(and(equals(?Set,<a,b,c,d>),union(<>,?Set,?Set)))'
		description: 'Is the union of the empty set with a set the same set?'.
	self processQuery: ' if succeeds(union(<>,<>,<>))' description:
			'Is the union of two empty sets the empty set?'
]

{ #category : #'term type checking' }
DataHandlingTest >> testvar [
	"var/1"

	
	self processQuery: ' if succeeds(var(?X))' description:
			'Does var/1 succeed for a variable?'.
	self processQuery: ' if fails(var(<>))' description:
			'Does var/1 fail for a non variable such as an empty list?'.
	self processQuery: ' if fails(var(<a,b,?x,d>))' description:
			'Does var/1 fail for a list (even when that list may contain variables)?'.
	self processQuery: ' if fails(var(<a,b,c,d>))' description:
			'Does var/1 fail for a fully instantiated list?'.
	self processQuery: ' if fails(var(hallo))' description:
			'Does var/1 fail for a symbol?'.
	self processQuery: ' if fails(var(5))' description:
			'Does var/1 fail for a number?'.
	self processQuery: ' if fails(var([TestClass1]))' description:
			'Does var/1 fail for a Smalltalk class?'
]
