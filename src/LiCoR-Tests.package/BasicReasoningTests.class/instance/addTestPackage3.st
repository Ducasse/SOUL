private
addTestPackage3
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage3'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass3 superclass: PackageTestClass2
		indexedType: #none private: false instanceVariableNames: ''
		classInstanceVariableNames: '' imports: '' category:
			'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage