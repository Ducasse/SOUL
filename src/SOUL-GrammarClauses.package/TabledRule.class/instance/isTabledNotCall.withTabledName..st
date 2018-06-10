private
isTabledNotCall: aCondition withTabledName: aString
	"checks if aCondition is of the form not(aString) where aString is path(a,b)/2"

	"valiant knight, please prepare for horror and a princess in another castle"

	
	| theElement |
	aCondition functor printString = 'not' ifFalse: [^false].	"we restrict this to nots with only 1 term"
	"TODO: change this? watch out as we need to do variable passing and other nasty stuff"

	aCondition termSequence size = 1 ifFalse: [^false].
	theElement := aCondition termSequence terms first.
	^aString
		= (theElement functor asString , theElement multiplicity asString)