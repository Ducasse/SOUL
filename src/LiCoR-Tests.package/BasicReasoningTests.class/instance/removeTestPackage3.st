private
removeTestPackage3
	
	PackageTestClass3 ifDefinedDo: [:cl | cl removeFromSystem].
	Registry removePackage: (Registry packageNamed: 'TestPackage3')