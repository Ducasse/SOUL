naming
isClassInPackageNamedXM2

"Class ?Class is defined in a package named ?PackageName
CASE 1: ?PackageName is bound"

?Class isClassInPackageNamed: +?PackageName if 
	?Package isPackageWithName: ?PackageName,?Class isClassInPackage: ?Package.
"Class ?Class is defined in a package named ?PackageName
CASE 2: ?PackageName is not bound"

?Class isClassInPackageNamed: -?PackageName if 
	?Class isClassInPackage: ?Package,?Package isPackageWithName: ?PackageName