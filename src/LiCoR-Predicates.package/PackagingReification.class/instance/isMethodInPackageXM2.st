binary relations
isMethodInPackageXM2

"Does ?Method belong to ?Package
Case 1: ?Package is bound"

?Method isMethodInPackage: +?Package if 
	?Package isPackage,[MLI forSmalltalk methodsInPackage: ?Package] contains: ?Method.
"Does ?Method belong to ?Package
Case 2: ?Package is not bound"

?Method isMethodInPackage: -?Package if 
	?Method isMethod,?Package equals: [MLI forSmalltalk packageForMethod: ?Method]