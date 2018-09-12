entities
isPackageM1

"Checks whether ?Package is a package, or retrieves all packages
Case 1: ?Package is bound"

+?Package isPackage if 
	[MLI forSmalltalk isPackage: ?Package].
"Checks whether ?Package is a package, or retrieves all packages
Case 1: ?Package is not bound"

-?Package isPackage if 
	[MLI forSmalltalk allPackageEntities] contains: ?Package