private
addTestPackage2
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage2'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass2 superclass: PackageTestClass1
		indexedType: #none private: false instanceVariableNames: ''
		classInstanceVariableNames: '' imports: '' category:
			'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage