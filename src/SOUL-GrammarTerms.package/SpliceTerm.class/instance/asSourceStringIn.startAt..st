quotedCode
asSourceStringIn: anEnv startAt: anIndex
	"see comment in AbstractTerm"

	"When a compound term is used inside a quotedCode, this method gets invoked when the quotedcode is dowed and this means that we need to convert to our 	previous quotedcode representation. If we are not a compound that was unified with a quotedcode, then we simply write our textual representation"

	
	| string list index |
	string := WriteStream on: String new.
	list := functor soulDownIn: anEnv startAt: anIndex.
	(list isKindOf: ListTerm) ifFalse: [^self asString].
	index := 0.
	list
		listDo:
			[:listTerm | 
			string
				nextPutAll:
					(listTerm class = Variable
						ifTrue:
							[index := index + 1.
							(self termSequence terms at: index) asSourceStringIn: anEnv startAt:
									anIndex]
						ifFalse: [listTerm asSourceStringIn: anEnv startAt: anIndex])].
	index = self termSequence size
		ifFalse:
			[self error: 'Incorrect number of arguments to compoundterm in quotedcode'].
	^string contents