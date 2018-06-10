private
clear
	
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	clauseArray := Array new: maxAddress.
	addressForPredicate := Dictionary new.
	currentAddress := 0.	" We should do something with these
	repositoryVariables := Dictionary new."

	exports := Dictionary new.
	self loadNatives