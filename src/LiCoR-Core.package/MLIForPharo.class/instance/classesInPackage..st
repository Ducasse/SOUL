packaging - binary relations
classesInPackage: aPackage
	^Smalltalk allClasses select:[:cl | cl category = aPackage]