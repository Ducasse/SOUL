soul auto saved
collectionMemberM2

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