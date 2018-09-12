classes
testIsAbstractClass
	
	self processQuery: ' if succeeds([TestClassRoot] isAbstractClass)'
		description:
			'This class is abstract because it implements an abstract method'.
	self processQuery: ' if succeeds([SubClass3] isAbstractClass)'
		description:
			'This class is abstract because it parent has an abstract method'.
	self processQuery: ' if fails([ConcreteSubClass] isAbstractClass)'
		description:
			'This class provides an implementation for all abstract methods'.
	self processQuery: ' if succeeds([AbstractSubclass] isAbstractClass)'
		description:
			'This class provides an implementation for all but one of its parents abstract methods'