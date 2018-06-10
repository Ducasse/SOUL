slgtesting
isSLGEquivalentToSymbiosisTerm: aSymbiosisTerm
	
	| val1 val2 |
	"we dont allow them as we can not store them efficiently:
	we either store them with environment + index in the tables (but the env's will be popped/destroyed, so that won't work),
	and we have to constantly evaluate them again in order to get the value"

	self halt:
			'you are using symbiosisterms with tabling... there be dragons here'.
	val1 := aSymbiosisTerm evaluateIn: nil startAt: nil.
	val2 := self evaluateIn: nil startAt: nil.
	^val1 = val2