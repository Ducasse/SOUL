methods
methodOverridesMethodXM2

"Does ?Method1 override ?Method2?

Case 1: Both arguments are bound"

+?Method1 methodOverridesMethod: +?Method2 if 
	?Method1 isMethodWithName: ?Selector inClass: ?Class1,?Method2 isMethodWithName: ?Selector inClass: ?Class2,?Class1 isClassBelow: ?Class2.
"Does ?Method1 override ?Method2?

Case 2: ?Method1 is bound; ?Method2 is not bound"

+?Method1 methodOverridesMethod: -?Method2 if 
	?Method1 isMethodWithName: ?Selector inClass: ?Class1,?Class1 isClassBelow: ?Class2,?Method2 isMethodWithName: ?Selector inClass: ?Class2.
"Does ?Method1 override ?Method2?

Case 3: ?Method1 is not bound; ?Method2 is bound"

-?Method1 methodOverridesMethod: +?Method2 if 
	?Method2 isMethodWithName: ?Selector inClass: ?Class2,?Class1 isClassBelow: ?Class2,?Method1 isMethodWithName: ?Selector inClass: ?Class1