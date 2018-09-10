debugging
testconditionalProceed
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