private
addTestPackage1
	
	| testPackage previousPackage |
	previousPackage := Registry currentPackage.
	testPackage := PackageModel named: 'TestPackage1'.
	Registry currentPackage: testPackage.
	Soul defineClass: #PackageTestClass1 superclass: Object indexedType: #none
		private: false instanceVariableNames: '' classInstanceVariableNames: ''
		imports: '' category: 'Soul-LogicTestClasses'.
	Registry currentPackage: previousPackage