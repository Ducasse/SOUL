private
removeTestPackage1
	
	PackageTestClass1 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage1')