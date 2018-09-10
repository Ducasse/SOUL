debugging
testinspectTerm
	"self run:#testinspectTerm"

	"This test checks whether the inspectTerm predicate indeed opens an inspector on the predicate given (tested with a string). If an inspector is found to exist on this string, it is closed."

	| query aString queryString |
	aString := '$$TestString for SUnit test testInspectTerm$$'.
	queryString := 'if inspectTerm([''' , aString , '''])'.
	query := SoulFactory current evaluatorForLogicQuery eval: queryString in: self repository.
	[ query allResults ]
		on: Exception
		do: [ :exc | 
			| inspector |
			inspector := GTInspector allInstances detect: [ :each | each entity = aString ] ifNone: [ nil ].
			inspector ifNotNil: [ inspector window delete ].
			self assert: exc asString = 'Halt' & inspector notNil ]