Class {
	#name : #SymbiosisLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
SymbiosisLayer >> collectionMemberM2 [

collectionMember(?term,+?coll) if 
	getEnv(?env,?),envLookup(?term,?termPointer),[| block hisIndex |
?coll isEmpty
	ifFalse:
		[block := SoulFactory current collectionMemberBlockWithTermPointer:
				?termPointer andEnvironment: ?env.
		hisIndex := ?env startUnify: 0.
		&blockargs
			unifyWith: ?coll asOrderedCollection soulUp
			inEnv: ?env
			myIndex: envIndex
			hisIndex: hisIndex
			inSource: true.
		&resblock
			unifyWith: block soulUp
			inEnv: ?env
			myIndex: envIndex
			hisIndex: hisIndex
			inSource: true.
		true]
	ifTrue: [false]],setResolver(?resblock,?blockargs)
]

{ #category : #'soul auto saved' }
SymbiosisLayer >> isSizeOfXM2 [

"todo: should eventually end up as alternative for length/2, but unification of an uppedobject with a pair term (in head of lenght) currently raises an error"

?size isSizeOf: +?collection if 
	[?collection isKindOf: Collection],!,?size equals: [?collection size].
?size isSizeOf: +?collection if 
	length(?collection,?size)
]

{ #category : #'soul auto saved' }
SymbiosisLayer >> listAsCollectionM2 [

"listAsCollection(+-?soullist,+-?collection) converts a SOUL list to a Smalltalk collection and vice-versa. 
	WARNING: the list as well as the collection cannot contain free variables!!!!"

listAsCollection(<>,[OrderedCollection new]) if 
	!.
listAsCollection(?soullist,?collection) if 
	atom(?collection),findall(?el,member(?el,?collection),?soullist).
listAsCollection(?soullist,?collection) if 
	var(?collection),getEnv(?env,?),envLookup(?soullist,?listPointer),equals(?collection,[?listPointer term
	collectIn: ?env
	startAt: ?listPointer envIndex])
]

{ #category : #'soul auto saved' }
SymbiosisLayer >> qc2listM2 [

"Convert a quotedcode to its list representation. The reverse remains to be done"

qc2list(+?qc,?list) if 
	envLookup(?qc,?qcPointer),envLookup(?list,?listPointer),getEnv(?env,?idx),[| theList startIndex |
theList := ?qc asList.
startIndex := ?env startUnify: 0.
?listPointer term
	unifyWith: theList
	inEnv: ?env
	myIndex: ?listPointer envIndex
	hisIndex: ?qcPointer envIndex
	inSource: true]
]

{ #category : #'soul auto saved' }
SymbiosisLayer >> sourceStringM2 [

"This predicate extracts a resulting string from a quotedCode or produces a quotedcode from a string "

sourceString(?quotedCode,?SmalltalkString) if 
	quotedCode(?quotedCode),equals(?SmalltalkString,[?quotedCode asString]).
sourceString(?quotedCode,?SmalltalkString) if 
	var(?quotedCode),ground(?SmalltalkString),equals(?quotedCode,[DownedQuotedCode fromString: ?SmalltalkString])
]
