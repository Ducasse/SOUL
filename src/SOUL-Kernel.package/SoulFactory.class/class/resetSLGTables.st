SLG - auxiliary
resetSLGTables
	
	CallsPerCID := Dictionary new.
	CallsPerPredicate := Dictionary new.
	CallIdCounter := 0.
	SLGCallStack := OrderedCollection new.
	DependentOn := Dictionary new.
	DependentNegatedOn := Dictionary new