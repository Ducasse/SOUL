classes
classImplementsSelectorXM2

"Does ?Class implement a method with selector ?Selector"

?Class classImplementsSelector: ?Selector if 
	?Class isClass,? isMethodWithName: ?Selector inClass: ?Class