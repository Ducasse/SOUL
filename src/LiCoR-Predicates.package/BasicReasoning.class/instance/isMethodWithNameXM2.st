naming
isMethodWithNameXM2

"Retrieve the name ?Selector of a method ?Method"

?Method isMethodWithName: ?Selector if 
	?Method isMethod,[MLI current methodNameOf: ?Method] equals: ?Selector