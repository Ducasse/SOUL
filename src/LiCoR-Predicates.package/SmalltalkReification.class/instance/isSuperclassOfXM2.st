binary relations
isSuperclassOfXM2

"?SuperClass isSuperclassOf: ?SubClass verifies whether ?SuperClass is a super class of
	 ?SubClass in the Smalltalk class hierachy. If one (or both) arguments are unbound,
	 the appropriate values will be produced for them.

Implementation note: In the implementation below some of the cases could have been
	 taken together in a single case, but for performance reasons we preferred to handle all
	 cases separately. This is a frequently used predicate that should be implemented as
	 efficient as possible.

CASE 1: +?SuperClass isSuperclassOf: +?SubClass"

+?SuperClass isSuperclassOf: +?SubClass if 
	?SuperClass isClass,?SubClass isClass,[MLI forSmalltalk is: ?SuperClass superclassOf: ?SubClass].
"CASE 2: -?SuperClass isSuperclassOf: +?SubClass"

-?SuperClass isSuperclassOf: +?SubClass if 
	?SubClass isClass,?SuperClass equals: [MLI forSmalltalk hasSuperclass: ?SubClass],[?SuperClass isNil not].
"CASE 3 & 4: +-?SuperClass isSuperclassOf: -?SubClass

?SuperClass may be either variable or not but it must be a class"

?SuperClass isSuperclassOf: -?SubClass if 
	?SuperClass isClass,[MLI forSmalltalk subclassesOf: ?SuperClass] contains: ?SubClass