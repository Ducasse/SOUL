Class {
	#name : #DataHandlingLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
DataHandlingLayer >> appendAtomsM3 [

"appendAtoms/3(+?A1,+?A2,+-?A3) concatenates 2 atoms or strings ?A1 and ?A2 into a third ?A3"

appendAtoms(?Atom1,?Atom2,?Atom3) if 
	atom(?Atom1),atom(?Atom2),equals(?Atom3,[(?Atom1 , ?Atom2) asSymbol]).
appendAtoms(?Atom1,?Atom2,?Atom3) if 
	not(and(atom(?Atom1),atom(?Atom2))),error(['appendAtoms/3 requires the two first arguments to be atoms!'])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> appendM3 [

"append/3 join or split lists

tested

append(?First, ?Second, ?Whole) (where ?First, ?Second and ?Whole are either lists or variables) joins or split lists.
If ?First and ?Second are instantiated, the ?Second list is appended to the end of the ?First list to give the ?Whole list.
If ?First, ?Second and ?Whole are instantiated, then test that the ?Whole list begins with the ?First list and that the remainder of the ?Whole list is the ?Second list.
If ?First and ?Whole are instantiated and the ?Whole list starts with the ?First list, then the remainder of the ?Whole list is returned as ?Second.
If ?Second and ?Whole are instantiated and the ?Whole list ends with the ?Second list then the beginning of the ?Whole list is returned as ?First.
If ?Whole is instantiated, the ?Whole list is  split at an arbitrary place to form two new sub-lists ?First and ?Second. Alternative solutions will be provided on backtracking."

append(<>,?List,?List).
append(<?ElFirst|?RestFirst>,?Second,<?ElFirst|?Rest>) if 
	append(?RestFirst,?Second,?Rest)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> assertM1 [

"assert(+?Term) asserts a clause (i.e., a fact or rule) that is given as a logic ?Term"

assert(&term) if 
	getRepository(?repository),getEnv(?env,?),[?repository
	addClause:
		(Fact
			condition:
				(SoulFactory current makeTermSequence terms: OrderedCollection new)
			conclusion: &term)]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> assertM2 [

"assert(+?Term,+?Repository) asserts a clause (i.e., a fact or rule) that is given as a logic ?Term
	 in a certain logic ?Repository"

assert(&term,?aRepository) if 
	getEnv(?env,?),[?aRepository
	addClause:
		(Fact
			condition:
				(SoulFactory current makeTermSequence terms: OrderedCollection new)
			conclusion: &term)]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> atomM1 [

"atom(?Term) succeeds if, and only if, ?Term is instantiated to a SOUL atom
	 (including the special atom denoting the empty list)"

atom(&Term) if 
	[(&Term isKindOf: UppedObject) | (&Term isKindOf: SmalltalkTerm)]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> atomToCharsM2 [

"atomToChars(+?Atom, +-?CharList) transforms an ?Atom to a ?CharList. The current implementation only works when ?Atom is bound to an atom. ?CharList on the other hand may or may not be variable.

CASE 1: atomToChars(+?Atom, -?CharList)"

atomToChars(?Atom,?CharList) if 
	atom(?Atom),var(?CharList),stringOrAtomToChars(?Atom,?CharList).
"CASE 2: atomToChars(+?Atom, +?CharList)"

atomToChars(?Atom,?CharList) if 
	atom(?Atom),nonvar(?CharList),atomToChars(?Atom,?AtomAsCharList),equals(?CharList,?AtomAsCharList)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> compoundM1 [

"tested by KM on 2002/04/04

compound(+-?Term) tests for a compound term. It succeeds if ?Term is a compound term and fails otherwise."

compound(&Term) if 
	[&Term isKindOf: CompoundTerm]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> concatQuotedTermsM3 [

"concatQuotedTerms(?ListOfQuotedTerms,?Separator, ?QuotedTerm) turns a ?ListOfQuotedTerms 
	 into a ?QuotedTerm with all those ?QuotedTerms in the order in which they
	 appear in the list separated by a ?Separator. No extra ?Separator at the end is
	 produced.

Note: a variant of this predicate that works on strings instead of quoted code terms is listAsSeparatedString/3

Special case: needed for when the empty list is passed as argument."

concatQuotedTerms(<>,?,{}).
"Ordinary Cases"

concatQuotedTerms(<?QuotedTerm>,?Separator,{?QuotedTerm}).
concatQuotedTerms(<?QuotedTerm|?OtherQuotedTerms>,?Separator,{?QuotedTerm?Separator?Rest}) if 
	nonEmptyList(?OtherQuotedTerms),concatQuotedTerms(?OtherQuotedTerms,?Separator,?Rest)
]

{ #category : #'collections and lists' }
DataHandlingLayer >> containsXM2 [

?c contains: ?e if 
	member(?e,?c)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> counterincrM1 [

"This predicate has a non-decarative semantics, it is meant mostly for writing test cases were there's a need to test the number of times a query is executed for example."

counterincr(+?x) if 
	[?x
	at: 1
	put: (?x at: 1) + 1.
true].
counterincr(-?x) if 
	equals(?x,[Array with: 1])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> countervalueM2 [

countervalue(-?counter,?value) if 
	equals(?counter,[Array with: ?value]).
countervalue(+?counter,?value) if 
	equals(?value,[?counter at: 1])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> deepflattenM2 [

"tested on 09-07-2001

deepflatten(+?ListOfNestedLists,+-?List) transforms a list of lists (which can again contain
	 lists, and so on) to a single list containing all elements of each of the sublists of the
	 original list of lists, in the same order. The list of nested lists that is provided as input
	 is supposed to be instantiated."

deepflatten(<>,<>).
deepflatten(?Item,<?Item>) if 
	not(list(?Item)).
deepflatten(?ListOfNestedLists,?List) if 
	nonvar(?ListOfNestedLists),equals(?ListOfNestedLists,<?First|?Rest>),deepflatten(?First,?FlatFirst),deepflatten(?Rest,?FlatRest),append(?FlatFirst,?FlatRest,?List)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> differenceM3 [

"converted on 2001-11-30 by Tom Mens

tested

calculates the set difference"

difference(?Set1,?Set2,?Diff) if 
	findall(?El,and(includes(?El,?Set1),not(includes(?El,?Set2))),?Diff)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> differsM2 [

"tested on 08-07-2001

differs(?X,?Y) is the opposite of equals(?X,?Y)
	 and verifies whether ?X and ?Y are NOT unifiable"

differs(?El1,?El2) if 
	not(equals(?El1,?El2))
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> disjointM2 [

"tested on 22/08/2001

disjoint(+?Set1,+?Set2) verifies whether two sets ?Set1 and ?Set2 are disjoint.
	 Both ?Set1 and ?Set2 are supposed to be instantiated."

disjoint(?Set1,?Set2) if 
	forall(includes(?El,?Set1),not(includes(?El,?Set2)))
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> elGroundMemberM2 [

elGroundMember(?El,<?El|?Rest>).
elGroundMember(?El,<?First|?Rest>) if 
	not(equals(?First,?El)),elGroundMember(?El,?Rest)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> elNotGroundMemberM2 [

elNotGroundMember(?El,<?El|?Rest>).
elNotGroundMember(?El,<?First|?Rest>) if 
	elNotGroundMember(?El,?Rest)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> emptyListM1 [

"tested on 09-07-2001"

emptyList(<>)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> endsWithM2 [

"tested on 10/09/2001

endsWith(+?String,+?Postfix) checks whether a given ?String ends with some ?Postfix
	 Both arguments are supposed to be instantiated upon calling this predicate. Warning:
	 the predicate is case-INsensitive, in other words it makes no distinction between capitals
	 and non-capitals when comparing strings.

Implementation note: the reason for the case-insensitivity has to do with the lower-level
	 Smalltalk primitive (i.e. #match:) that was used to implement this predicate. It was no
	 deliberate design decision for the predicate."

endsWith(?AString,?APostfix) if 
	or(var(?AString),var(?APostfix)),error(['endsWith/2 was called with one or both arguments variable!']).
endsWith(?AString,?APostfix) if 
	['*' , ?APostfix match: ?AString]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> equalsM2 [

"tested on 08-07-2001

equals/2 tries to unify two terms. If this is unsuccesful, the result is false.
	 If it is successful, the necessary bindings will have been added to the environment."

equals(?X,?X)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> equalsStructureListM2 [

"=..

equalsStructureList(?Term, ?List) is the SOUL equivalent of the Prolog construct =.. and
	 defines the relationship between a compound ?Term and a ?List.

	?List is a list whose first element is the principal functor of the ?Term, and whose tail
	is the list of arguments of ?Term.

	If ?Term is an uninstantiated variable, then ?List must be a list with instantiated head.
	A compound term will be constructed from the list. The functor of the term will be the head of the list, 
	while the arguments of the term will be the tail of the list.

	If ?Term is not a variable, then the corresponding list is constructed and unified with ?List

	If ?Term is not compound but just a symbol, then it unifies with a list containing just that symbol.

CASE 0: ?Term is not compound term but just a symbol"

equalsStructureList(?Term,<?Term>) if 
	symbol(?Term).
"CASE 1a: ?Term is an uninstantiated variable and ?List is a list with instantiated head"

equalsStructureList(?Term,<?head|?rest>) if 
	var(?Term),atom(?head),not([?head = ListTerm ListTermFunctor smalltalkValue]),subStructureList(?collection,?rest,?termPointerList,0),getEnv(?env,?),getRepository(?rep),envLookup(?Term,?TermPointer),length(?termPointerList,?length),[| newCollection newTerm count startIndex |
newCollection := OrderedCollection new.
count := 0.
startIndex := ?env startUnify: ?length + 1.
?termPointerList
	listDo:
		[:aVarPointer | 
		| var |
		var := (Variable name: 'temp') setAddress: count.
		newCollection add: var.
		var
			unifyWith: aVarPointer smalltalkValue term
			inEnv: ?env
			myIndex: startIndex
			hisIndex: aVarPointer smalltalkValue envIndex
			inSource: false.
		count := count + 1].
?head = ListTerm ListTermFunctor smalltalkValue
	ifTrue:
		[self halt.
		newCollection add: EmptyListConstant new.
		newTerm := SoulFactory current makeList new makeListCompound: newCollection]
	ifFalse:
		[newTerm := SoulFactory current makeCompound
			functor: ?head soulUp
			termSequence: (TermSequence terms: newCollection)
			astLink: ((HiddenVariable name: SoulFactory uniqueName) setAddress: ?length)].
newTerm definitionRepository: ?rep.
?TermPointer term
	unifyWith: newTerm
	inEnv: ?env
	myIndex: ?TermPointer envIndex
	hisIndex: startIndex
	inSource: true.
true].
"CASE 1b: The head is list-functor"

equalsStructureList(?Term,<?head,?car,?cdr>) if 
	var(?Term),atom(?head),[?head = ListTerm ListTermFunctor smalltalkValue],equals(?Term,<?car|?cdr>).
"CASE 2: ?Term is not a variable but a compound term"

equalsStructureList(?Term,?List) if 
	compound(?Term),envLookup(?List,?ListPointer),envLookup(?Term,?TermPointer),getEnv(?env,?),[| listTerm |
listTerm := ListTerm
	termSequence:
		((OrderedCollection new)
			add: ?Term functor;
			addAll: ?Term termSequence terms;
			yourself).
?ListPointer term
	unifyWith: listTerm
	inEnv: ?env
	myIndex: ?ListPointer envIndex
	hisIndex: ?TermPointer envIndex
	inSource: true]
]

{ #category : #comparing }
DataHandlingLayer >> equalsXM2 [

?x equals: ?x
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> flattenM2 [

"tested on 22/08/2001

flatten(+?ListOfLists,+-?List) transforms a list of lists to a single list containing all
	 elements of each of the sublists of the original list of lists, in the same order.
	 The list of lists is supposed to be instantiated. The flattened list can either be
	 instantiated or not."

flatten(<>,<>).
flatten(<?First|?Rest>,?Result) if 
	flatten(?Rest,?FlatRest),append(?First,?FlatRest,?Result)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> groundM1 [

"tested on 05-07-2001

ground(+-?Term) succeeds if ?Term is currently instantiated to a term that is completely 
	 bound (has no uninstantiated variables in it); otherwise it fails"

ground(&X) if 
	[| result varVisitor |
result := true.
varVisitor := AllButHiddenVariablesVisitor
	doBlock: [:var | result := false].
&X accept: varVisitor.
result]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> headM2 [

"tested on 22/08/2001

head(+-?Element,+?List) unifies ?Element with the first element of ?List.
	 ?Element can either be instantiated or not. ?List should be instantiated,
	 although it may be only instantiated partially."

head(?First,<?First|?Rest>)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> includesM2 [

"tested on 27/08/2001

includes(+-?Element, +?Set) is the equivalent for sets of member/2 which works on lists.
	 (But since we represents sets as list too, includes/2 is directly implemented in 
	 terms of member/2.) The first argument ?Element can either be instantiated or not,
	 the second argument ?Set must be instantiated upon calling the predicate."

includes(?Element,?Set) if 
	member(?Element,?Set)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> intersectionListsM2 [

"tested

Get a list with the common elements in a list of lists. For example:
		intersectionLists(<<[1],[2],[42]>,<[2],[3],[42]>,<[3],[4],[42]>>, <[42]>)

Passing variables as lists, or even variables within the lists, is NOT allowed."

intersectionLists(?lists,?intersectionList) if 
	forall(member(?list,?lists),ground(?list)),privateIntersectionLists(?lists,?intersectionList)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> intersectionM3 [

"tested on 22/08/2001

intersection(+?Set1,+?Set2,+-?Intersection) computes the ?Intersection of two sets ?Set1 and
	 ?Set2. Both ?Set1 and ?Set2 are supposed to be instantiated. ?Intersection can either be
	 instantiated or not. It contains the computed intersection. The order of the elements in
	 the intersection will be the same as the order in which the corresponding elements
	 appear in ?Set1"

intersection(?Set1,?Set2,?Intersection) if 
	findall(?El,and(includes(?El,?Set1),includes(?El,?Set2)),?Intersection)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> lastMemberOfXM2 [

?last lastMemberOf: <?last>.
?last lastMemberOf: <?|?rest> if 
	?last lastMemberOf: ?rest
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> lengthM2 [

"partially converted

tested

only works if the list if a real list, does not work when list is a variable

get the length of a list
 If Term is a list, Length will be unified with the number of items in the list. 
 If Length is an integer and Term is unbound, Term will be unified with a list of 
 variables of the specified Length."

length(<>,[0]).
length(<?car|?cdr>,-?length) if 
	length(?cdr,?x),equals(?length,[?x + 1]).
"Warning: ?l of length(?l, 3) may print as <?car, ?car, ?car>, but the ?car named variables are distinct in reality"

length(<?car|?cdr>,+?length) if 
	[?length > 0],length(?cdr,[?length - 1])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> listAsSeparatedStringM3 [

"listAsSeparatedString(?ListOfSymbols,?Separator, ?String) turns a ?ListOfSymbols (or
	 strings) into a ?String with all those symbols in the order in which they
	 appear in the list separated by a ?Separator. No extra ?Separator at the end is
	 produced.

Note: a variant for this predicate that works on quoted terms instead of symbols/strings is concatQuotedTerms/3.

Special case: needed for when the empty list is passed as argument."

listAsSeparatedString(<>,?,['']).
"Base case: stop without a space if the list just contains one single element."

listAsSeparatedString(<?el>,?,[?el asString]).
"Recursive case: take the first element followed by a space, followed by a
	 the other elements."

listAsSeparatedString(<?el|?rest>,?Separator,?string) if 
	not(emptyList(?rest)),listAsSeparatedString(?rest,?Separator,?reststring),equals(?string,[?el asString , ?Separator , ?reststring])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> listM1 [

list(&term) if 
	[(&term isKindOf: ListTerm) | (&term isKindOf: EmptyListConstant)]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> listMemberM2 [

listMember(?El,?List) if 
	ground(?El),elGroundMember(?El,?List).
listMember(?El,?List) if 
	nonground(?El),list(?List),elNotGroundMember(?El,?List)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> makeFirstCapitalLowerCaseM2 [

"Soul.SoulTests.DataHandlingTest run: #testmakeFirstCapitalLowerCase

makeFirstCapitalLowerCase(+?String,+-?NewString) transforms a ?String into a new one where
 the first characted is converted into a lower case one (if it was already a lower case one, the new
 string is just a copy of the old one"

makeFirstCapitalLowerCase(?String,?NewString) if 
	string(?String),equals(?NewString,[| x |
x := ?String copy.
x
	at: 1
	put: x first asLowercase.
x])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> mapM3 [

"sequential call of the predicate on the lists, with element of first list as first arg and element of second list as second arg"

map(<>,<>,?).
map(<?elfirst|?restfirst>,<?elsecond|?restsecond>,?predicate) if 
	?predicate(?elfirst,?elsecond),map(?restfirst,?restsecond,?predicate)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> memberM2 [

"tested on 28/08/2001

member(+-?Element,+-?List) gets or checks a member of a list. If ?Element is instantiated,
	 member/2 will check that it is a member of the list ?List (if ?List is a variable, it will be bound
 	 to a list that contains ?Element). If ?Element is a variable, it will be bound to the first element
	 of ?List. On backtracking, it will be bound to successive elements of ?List.

	 Usage note: As opposed to the implementation of member/2 in Prolog, the predicate will fail 
	 when both ?Element and ?List are variable!"

member(?El,+?Collection) if 
	[?Collection isKindOf: Collection],collectionMember(?El,?Collection).
member(?El,?List) if 
	or(list(?List),var(?List)),listMember(?El,?List)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> noDupsM2 [

"tested on 22/08/2001

noDups(+?ListWithDuplicates,+-?ListWithoutDuplicates) checks whether ?ListWithoutDuplicates
	 is the same (up to a permutation of its elements) as ?ListWithDuplicates after all of its
	 duplicate elements have been removed. The ?ListWithDuplicates is supposed to be instantiated.
	 The ?ListWithoutDuplicates can either be instantiated, or it can be uninstantiated in which
	 case the appropriate value will be generated for it."

noDups(+?listWithDuplicates,?noDupsList) if 
	var(?noDupsList),nonvar(?listWithDuplicates),listAsCollection(?listWithDuplicates,?withDuplicates),listAsCollection(?noDupsList,[?withDuplicates asSet]).
noDups(+?listWithDuplicates,+?noDupsList) if 
	nonvar(?noDupsList),nonvar(?listWithDuplicates),listAsCollection(?listWithDuplicates,?withDuplicates),listAsCollection(?noDupsList,?noDups),[| result withDuplicatesRemoved |
withDuplicatesRemoved := ?withDuplicates asSet.
result := withDuplicatesRemoved size = ?noDups size
	and: [?noDups allSatisfy: [:each | withDuplicatesRemoved includes: each]].
result]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> nonEmptyListM1 [

"tested on 28/08/2001

nonEmptyList(+?List) checks whether ?List is a non-empty list. The argument is supposed
	 to be instantiated.

Implementation note: the order of the predicants in the rule below is important."

nonEmptyList(?List) if 
	var(?List),error(['nonEmptyList/1 was called with a variable argument!']).
nonEmptyList(?List) if 
	not(emptyList(?List)),list(?List)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> nongroundM1 [

"tested on 21/08/2001

nonground(?Term) states that the argument ?Term is non-ground, 
	 i.e. contains at least one unbound variable."

nonground(?Term) if 
	not(ground(?Term))
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> nonvarM1 [

"tested on 21/08/2001

nonvar(+-?Term) succeeds if, and only if, Term is instantiated. It is the opposite of var/1"

nonvar(?Term) if 
	not(var(?Term))
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> privateIntersectionListsM2 [

privateIntersectionLists(<?first|?rest>,?intersectedList) if 
	list(?first),list(?rest),privateIntersectionListsRecursion(?first,?rest,?intersectedList)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> privateIntersectionListsRecursionM3 [

"intersect the first argument (with the already intersected lists) with the first
	element of the ones to do (the head of the second argument). Then do a recursive step.
	When the recursion returns, ?intersection will have the result"

privateIntersectionListsRecursion(?done,<?todoFirst|?todoRest>,?intersection) if 
	intersection(?done,?todoFirst,?intersectedFirst),privateIntersectionListsRecursion(?intersectedFirst,?todoRest,?intersection).
"stop condition: nothing more to do (the second list), so the resulting intersection is in ?L.
	Assign this as the solution. Because we are now at the deepest  recursin level,
	we will now rise again to the top, passing the result in the last variable"

privateIntersectionListsRecursion(?L,<>,?L)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> quotedCodeM1 [

quotedCode(&term) if 
	[&term isKindOf: QuotedCodeTerm]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> removeAuxM3 [

removeAux(<?X|?L>,?X,?L).
removeAux(<?Y|?L1>,?X,<?Y|?L2>) if 
	not(equals(?X,?Y)),removeAux(?L1,?X,?L2)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> removeM3 [

"tested on 28/08/2001

remove(+-?List,+-?Element,+-?ListWithoutElement) removes the first occurence of
	 ?Element from a list ?List and yields a new list ?ListWithoutElement. If ?List is variable,
	 the ?Element will be inserted somewhere in ?ListWithoutElement. It is assumed that
	 at least one of the lists is non-variable when calling the predicate."

remove(?List,?Element,?ListWithoutElement) if 
	and(var(?List),var(?ListWithoutElement)),error(['remove/3 was called with two variable lists!']).
remove(?List,?Element,?ListWithoutElement) if 
	removeAux(?List,?Element,?ListWithoutElement)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> retractM1 [

"not tested

retract(+?Term)  retracts the first occurence of a clause with a given head ?Term from the default logic repository"

retract(&term) if 
	nonvar(&term),getRepository(?repository),getEnv(?env,?),[?repository
	retract: (&term predicateInEnv: ?env startAt: nil)
	multiplicity: &term multiplicity]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> retractMatchM1 [

"retractMatch(+?Term) retracts all occurence of a clause of which the head unifies with ?Term"

retractMatch(&term) if 
	nonvar(&term),getRepository(?repository),getEnv(?env,?),envLookup(&term,?index),[| clauses result |
result := false.
clauses := ?repository
	clausesForKey: (&term predicateKeyInEnv: ?env startAt: nil)
	ifAbsent: [#()].
clauses
	do:
		[:aClause | 
		| i |
		i := ?env startUnifyWith: aClause.
		(&term
			unifyWith: aClause conclusion
			inEnv: ?env
			myIndex: ?index
			hisIndex: i
			inSource: true)
			ifTrue:
				[?repository removeClause: aClause.
				result := true].
		?env rollback].
result]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> retractMatchM2 [

"retractMatch(+?Term,+?conditionPredicate) retracts all occurence of a clause of which the head unifies with ?Term"

retractMatch(&term,&conditionPredicate) if 
	nonvar(&term),nonvar(&conditionPredicate),getRepository(?repository),getEnv(?env,?),envLookup(&term,?termPointer),collectionMember(?clause,[| clauses result i |
result := OrderedCollection new.
clauses := ?repository
	clausesForKey: (&term predicateKeyInEnv: ?env startAt: nil)
	ifAbsent: [#()].
clauses
	do:
		[:aClause | 
		i := ?env startUnifyWith: aClause.
		(?termPointer term
			unifyWith: aClause conclusion
			inEnv: ?env
			myIndex: ?termPointer envIndex
			hisIndex: i
			inSource: true) ifTrue: [result add: aClause].
		?env rollback].
result]),apply(&conditionPredicate,<?clause>),[?repository removeClause: ?clause]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> retractallM1 [

"not tested

retractall(+?Term) retracts all occurences of a clause with a given head ?Term from the default logic repository"

retractall(&term) if 
	nonvar(?term),getRepository(?repository),getEnv(?env,?),[?repository
	retractAll: (&term predicateInEnv: ?env startAt: nil)
	multiplicity: &term multiplicity]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> reverseM2 [

"tested on 28/08/2001

reverse(+?List,+-?ReversedList)
	 reverse(-?List,+?ReversedList)
	 reverses a given list. At most one argument may be uninstantiated."

reverse(?List,?ReversedList) if 
	var(?List),var(?ReversedList),error(['reverse/2 was called with both arguments variable!']).
reverse(?List,?ReversedList) if 
	reverse(?List,<>,?ReversedList)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> reverseM3 [

reverse(<>,?ReversedList,?ReversedList).
reverse(<?Head|?Tail>,?ReversedSoFar,?ReversedList) if 
	reverse(?Tail,<?Head|?ReversedSoFar>,?ReversedList)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> sameElementsM2 [

"tested on 05-07-2001

Returns whether two lists have the same elements. 
	The order of the elements is not important"

sameElements(?list1,?list2) if 
	list(?list1),list(?list2),subSetOf(?list1,?list2),subSetOf(?list2,?list1).
sameElements(?list1,?list2) if 
	or(and(var(?list1),list(?list2)),and(list(?list1),var(?list2))),equals(?list1,?list2)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> startsAndEndsWithM3 [

"CASE 1: ?Start and ?End are known"

startsAndEndsWith(?AString,+?Start,+?End) if 
	string(?Start),string(?End),equals(?AString,[?Start speciesAppend: ?End]).
"CASE 2: ?AString and ?Start are known"

startsAndEndsWith(+?AString,+?Start,-?End) if 
	string(?AString),string(?Start),[?Start , '*' match: ?AString],equals(?End,[?AString
	speciesCopyFrom: ?Start size + 1
	to: ?AString size]).
"CASE 3: ?AString and ?End are known"

startsAndEndsWith(+?AString,-?Start,+?End) if 
	string(?AString),string(?End),['*' , ?End match: ?AString],equals(?Start,[?AString
	speciesCopyFrom: 1
	to: ?AString size - ?End size])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> startsWithM2 [

"tested on 28/08/2001

startsWith(+?String,+?Prefix) checks whether a given ?String starts with some ?Prefix
	 Both arguments are supposed to be instantiated upon calling this predicate. Warning:
	 the predicate is case-INsensitive, in other words it makes no distinction between capitals
	 and non-capitals when comparing strings.

Implementation note: the reason for the case-insensitivity has to do with the lower-level
	 Smalltalk primitive (i.e. #match:) that was used to implement this predicate. It was no
	 deliberate design decision for the predicate."

startsWith(?AString,?APrefix) if 
	or(var(?AString),var(?APrefix)),error(['startsWith/2 was called with one or both arguments variable!']).
startsWith(?AString,?APrefix) if 
	[?APrefix , '*' match: ?AString]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringM1 [

"tested on 06/09/2001

string(+-?Term) succeeds if, and only if, ?Term is a Smalltalk string or symbol."

string(&Term) if 
	atom(&Term),[?Term isString]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringOrAtomM1 [

"not tested

stringOrAtom(+-?Something) checks whether ?Something is a Smalltalk string or QSOUL atom.

Implementation note: in QSOUL, strings are considered as a special kind of atoms."

stringOrAtom(?StringOrAtom) if 
	atom(StringOrAtom)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringOrAtomSplitM4 [

"stringOrAtomSplit(+?StringOrAtom,+?SubStringOrAtom,+-?BeforeString,+-?AfterString) is the same as stringSplit/4, but
also works for atoms. It computes the part of StringOrAtom that can be found before and after a given substring (or atom).
(More than one solution is possible if SubStringOrAtom occurs more than one time in StringOrAtom).
USAGE NOTE: The variables StringOrAtom and SubStringOrAtom are not allowed to be unbound variables when this
predicate is called.

Implementation note: in fact we do not need to handle the case for atoms separately. Apparently this case is already
handled automatically due to an automatic conversions of Smalltalk atoms to Smalltalk strings. So we can just use the
stringSplit predicate instead. In fact, this predicate stringOrAtomSplit is thus not really needed anymore, but is still here
because it might be called by other predicates."

stringOrAtomSplit(?StringOrAtom,?SubStringOrAtom,?BeforeString,?AfterString) if 
	stringSplit(?StringOrAtom,?SubStringOrAtom,?BeforeString,?AfterString)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringOrAtomStartsWithM3 [

"stringOrAtomStartsWith(+?StringOrAtom, ?Start, ?After) is the same as startsAndEndsWith/3, but
also works for atoms. It checks whether a ?StringOrAtom starts with a substring or atom ?Start,
and puts the remainder of the ?StringOrAtom in a string ?After.
USAGE NOTE: The variable StringOrAtom is not allowed to be an unbound variable when this predicate is called.

Implementation note: in fact we do not need to handle the case for atoms separately. Apparently this case is already
handled automatically due to an automatic conversions of Smalltalk atoms to Smalltalk strings. So we can just use the
startsAndEndsWith predicate instead. In fact, this predicate stringOrAtomStartsWith is thus not really needed anymore, but is still here
because it might be called by other predicates."

stringOrAtomStartsWith(?StringOrAtom,?Start,?After) if 
	startsAndEndsWith(?StringOrAtom,?Start,?After)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringOrAtomToCharsM2 [

"tested

stringOrAtomToChars(+-?StringOrAtom, +-?CharList) transforms a ?StringOrAtom to a ?CharList."

stringOrAtomToChars(?StringOrAtom,?CharList) if 
	stringOrAtom(?StringOrAtom),equals(?collection,[| collection newCollection |
collection := ?StringOrAtom asOrderedCollection.
newCollection := collection copyEmpty.
collection do: [:each | newCollection add: each asSymbol].
newCollection]),listAsCollection(?CharList,?collection)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringSplitM4 [

"tested on 28/08/2001

stringSplit(+?String,+?SubString,+-?Before,+-?After) computes the part of ?String that
	 can be found ?Before and ?After a given ?Substring. 
	 More than one solution is possible if ?SubString occurs more than one time in ?String.
	 The variables ?String and ?SubString are not allowed to be unbound variables when
	 this predicate is called. Both ?Before and ?After can either be variable or not.
	 ?SubString is supposed to be non-empty, otherwise the predicate will fail.

Implementation note: The predicate is implemented by using a piece of Smalltalk code
	 which generates all possible positions in the string where the substring is located."

stringSplit(?AString,?SubString,?Before,?After) if 
	or(var(?AString),var(?SubString)),error(['stringSplit/4 was called with first and/or second argument variable!']).
stringSplit(?AString,?SubString,?Before,?After) if 
	member(?Index,[| index allIndexes |
index := 0.
allIndexes := OrderedCollection new.
[index := ?AString
	findString: ?SubString
	startingAt: index + 1.
index == 0] whileFalse: [allIndexes add: index].
allIndexes]),equals(?Before,[?AString
	speciesCopyFrom: 1
	to: ?Index - 1]),equals(?After,[?AString
	speciesCopyFrom: ?Index + ?SubString size
	to: ?AString size])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> stringToCharsM2 [

"stringToChars(+-?String, +-?CharList) transforms a ?String to a ?CharList."

stringToChars(?String,?CharList) if 
	string(?String),stringOrAtomToChars(?String,?CharList)
]

{ #category : #collections }
DataHandlingLayer >> subSetOfM2 [

subSetOf(+?Set1,+?Set2) if 
	forall(member(?El,?Set1),member(?El,?Set2))
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> subStructureListM4 [

"Auxiliary predicate for constructing a compound term from an instantiated list."

subStructureList(?coll,<>,<>,?) if 
	equals(?coll,[OrderedCollection new]).
subStructureList(?coll,<?car|?cdr>,<?carPointer|?varRest>,?count) if 
	subStructureList(?collection,?cdr,?varRest,[?count + 1]),envLookup(?car,?carPointer),equals(?coll,[?collection
	addFirst: ((Variable name: 'temp') setAddress: ?count);
	yourself])
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> sublistOfM2 [

sublistOf(?sublist,?list) if 
	append(?sublist,?,?list).
sublistOf(?sublist,<?|?rest>) if 
	sublistOf(?sublist,?rest)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> symbolM1 [

"tested on 06/09/2001

symbol(+-?Term) succeeds if and only if ?Term is a Smalltalk symbol."

symbol(&Term) if 
	atom(&Term),[?Term isSymbol]
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> tailM2 [

"tested on 22/08/2001

tail(+-?RestList, +?List) unifies ?RestList with ?List without its first element.
	 ?RestList can either be instantiated or not. ?List must be instantiated, although
	 it may be only partially instantiated."

tail(?Rest,<?First|?Rest>)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> unionM3 [

"reimplemented by Tom Mens to make it more consistent with the definitions of the oher set handling operators

tested on 22/08/2001

union(+?Set1,+?Set2,+-?Union) computes the ?Union of two sets ?Set1 and ?Set2.
	 Both ?Set1 and ?Set2 are supposed to be instantiated. ?Union can either be instantiated
	 or not. The order of the elements in the ?Union is the order of which the elements
	 occur in ?Set1 and ?Set2 respectively.

Note: the implementation below is a rather slow one, because noDups/2 is very slow.

Old implementation was:
union(?Set1,?Set2,?Union) if
	append(?Set1,?Set2,?UnionWithDups),
	noDups(?UnionWithDups,?Union).

"

union(?Set1,?Set2,?Union) if 
	findall(?El,or(includes(?El,?Set1),includes(?El,?Set2)),?UnionWithDups),noDups(?UnionWithDups,?Union)
]

{ #category : #'soul auto saved' }
DataHandlingLayer >> varM1 [

"tested on 21/08/2001

var(+-?Term) succeeds if, and only if, ?Term is an unbound variable.
	 An unbound variable is one which has not been bound to another term
	 (other than another uninstantiated variable)."

var(&Term) if 
	[&Term isKindOf: SoulFactory current makeVariable]
]
