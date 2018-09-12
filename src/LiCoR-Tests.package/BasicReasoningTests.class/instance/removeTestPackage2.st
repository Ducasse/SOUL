private
removeTestPackage2
	
	PackageTestClass2 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage2')