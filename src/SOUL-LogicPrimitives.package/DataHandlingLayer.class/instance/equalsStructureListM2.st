soul auto saved
equalsStructureListM2

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