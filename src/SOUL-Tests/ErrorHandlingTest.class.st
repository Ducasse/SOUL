Class {
	#name : #ErrorHandlingTest,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #private }
ErrorHandlingTest >> inspectorClassUsedFor: anObject [
	
	^anObject inspectorClass
]

{ #category : #debugging }
ErrorHandlingTest >> testconditionalProceed [
	"self run:#testconditionalProceed"

	"The conditonalProceed predicate opens a dialog box with the supplied string, and succeeds if the user answers yes or fails if the user answers no.
	 This is not tested in the unit test, because the result needs user interaction, and depends on the choice of the user.
	You can manually test the predicate using the following statements:
		The result of the following should be true if you answer 'Yes' in the dialog:
			(SOULEvaluator eval: 'if conditionalProceed([''Answer YES''])' in: Factory defaultRepository)
				allResults success == true.

		The result of the following should be true if you answer 'No' in the dialog:
			(SOULEvaluator eval: 'if conditionalProceed([''Answer NO''])' in: Factory defaultRepository)
				allResults success == false.
	"

	
	self processQuery: ' if [true]' description:
			'Needs to be tested manually, since user interation is required (see the comment in #testconditionalProceed).'
]

{ #category : #errors }
ErrorHandlingTest >> testerror [
	"self run:#testerror"

	"Normally, one would do:
		self should: [query allResults] raise: Error
	But I wanted to check the error message as well, so I do this more extensive version."

	
	| query |
	query := SoulFactory current evaluatorForLogicQuery
		eval: 'if error([''Error for the SUnit testcase''])'
		in: self repository.
	[query allResults]
		on: SoulRuntimeException
		do:
			[:exc | self assert: exc messageText = 'SOUL >> Error for the SUnit testcase']
]

{ #category : #debugging }
ErrorHandlingTest >> testinspectTerm [
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
]
