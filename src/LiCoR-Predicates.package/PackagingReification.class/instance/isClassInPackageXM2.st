binary relations
isClassInPackageXM2

"Predicate that verifies whether ?Class belongs to ?Package
Case 1: Both ?Class and ?Package are bound"

+?Class isClassInPackage: +?Package if 
	?Class isClass,?Package isPackage,[MLI forSmalltalk isClass: ?Class inPackage: ?Package].
"Predicate that verifies whether ?Class belongs to ?Package
Case 2:  ?Class is unbound;  ?Package is bound"

-?Class isClassInPackage: +?Package if 
	?Package isPackage,[MLI forSmalltalk classesInPackage: ?Package] contains: ?Class.
"Predicate that verifies whether ?Class belongs to ?Package
Case 3:  ?MetaClass is a meta class (bound);  ?Package is bound"

+?MetaClass isClassInPackage: +?Package if 
	?MetaClass isMetaClass,?Package isPackage,?MetaClass isMetaClassOf: ?Class,[MLI forSmalltalk classesInPackage: ?Package] contains: ?Class.
"Predicate that verifies whether ?Class belongs to ?Package
Case 4:  ?Package is unbound"

?Class isClassInPackage: -?Package if 
	?Class isClass,?Package equals: [MLI forSmalltalk packageForClass: ?Class]