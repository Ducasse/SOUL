initialize-release
initialize
	
	WaitList := OrderedCollection new.
	NameCounter := 0.
	Repositories := Dictionary new.
	RepositoriesDependents := Set new.
	self resetSLGTables