private
detectRegexPrimitive: aTermCollection
	
	| termFunctor |
	aTermCollection
		do:
			[:term | 
			term isCompoundTerm
				ifTrue:
					[termFunctor := term functor name.
					(RegexTerm keywords
						at: termFunctor
						ifAbsent: [nil]) ifNotNil: [^term]]].
	^nil