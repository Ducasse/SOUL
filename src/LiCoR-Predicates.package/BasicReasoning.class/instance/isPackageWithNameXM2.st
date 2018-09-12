naming
isPackageWithNameXM2

"Retrieves the ?Name of a ?Package"

?Package isPackageWithName: ?Name if 
	?Package isPackage,?Name equals: [MLI forSmalltalk nameForPackage: ?Package]