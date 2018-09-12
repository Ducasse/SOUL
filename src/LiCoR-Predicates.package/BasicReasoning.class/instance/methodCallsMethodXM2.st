method body
methodCallsMethodXM2

"Does ?Method1 potentially call ?Method2?
This is only a coarse-grained over-estimation: all methods with the correct selector are looked for

Case 1: ?Method2 is not bound; find all methods matching a selector invoked in ?Method1"

?Method1 methodCallsMethod: -?Method2 if 
	?Method1 methodSendsSelector: ?Selector,?Method2 isMethodWithName: ?Selector.
"Does ?Method1 potentially call ?Method2?
This is only a coarse-grained over-estimation: all methods with the correct selector are looked for

Case 2: ?Method2 is bound; Check if ?Method1 calls the selector implemented by ?Method2"

?Method1 methodCallsMethod: +?Method2 if 
	?Method2 isMethodWithName: ?Selector,?Method1 methodSendsSelector: ?Selector