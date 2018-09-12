classes
isClassInHierarchyOfXM2

"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 1: Both ?Sub and ?Root are bound"

+?Sub isClassInHierarchyOf: +?Root if 
	?Sub isClass,?Root isClass,[MLI current is: ?Sub below: ?Root].
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 2: ?Sub is bound; ?Root is not bound"

+?Sub isClassInHierarchyOf: -?Root if 
	?Sub isClass,[MLI current allSuperclassesOf: ?Sub] contains: ?Root.
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 3: ?Sub is not bound; ?Root is  bound"

-?Sub isClassInHierarchyOf: +?Root if 
	?Root isClass,[MLI current allSubclassesOf: ?Root] contains: ?Sub.
"The class ?Sub is a class in the hierarchy of class ?Root (including that rootclass)
Case 4: ?Sub and ?Root are not bound"

-?Sub isClassInHierarchyOf: -?Root if 
	?Root isClass,?Sub isClassInHierarchyOf: ?Root