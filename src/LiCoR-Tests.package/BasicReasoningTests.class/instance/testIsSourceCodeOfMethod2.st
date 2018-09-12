methods
testIsSourceCodeOfMethod2
	
	self processQuery:
			' if ?Method isMethodWithName: array inClass: [TestClass1],?Source isSourceCodeOfMethod: ?Method,[?Source asString] equals:[(TestClass1>>#array) getSource ] ' description: 'Retrieve the source code of this method'