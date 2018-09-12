packaging - binary relations
isClass: aClass inPackage: aPackage
	| package |
	package  := self packageForClass: aClass.
	^package = aPackage