naming
classMethodWithNameInClassM3

"defines the name (selector) of a CLASS method in a class."

classMethodWithNameInClass(?method,?selector,?class) if 
	classMethodInClass(?method,?class),methodWithName(?method,?selector)