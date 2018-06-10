converting
asPredicateNameInEnv: anEnv startAt: idx
	"UGLY: the recursive sending of asPredicateNameInEnv might be better replaced with a new message, asKeywordInEnv ..."

	
	^self keywords
		inject: ''
		into:
			[:predicateName :keyword | predicateName , (keyword asPredicateNameInEnv: anEnv startAt: idx) , ':']