update mechanism
addStorageDependentClass: aClass
	
	(self storageDependents includes: aClass)
		ifFalse: [self storageDependents add: aClass]