initialize
initialize
	"Called by the #new class method and initializes all necessary variables"

	
	maxAddress := 500.
	clauseArray := Array new: maxAddress.
	addressForPredicate := Dictionary new.
	currentAddress := 0.
	fromLayers := OrderedCollection new.
	repositoryVariables := Dictionary new.
	exports := Dictionary new.
	self loadNatives.
	storageChanged := false.
	name := 'unnamed repository'.
	tabledRules := OrderedCollection new.
	additionalClauses := OrderedCollection new