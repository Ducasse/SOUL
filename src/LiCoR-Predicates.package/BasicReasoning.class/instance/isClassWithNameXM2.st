naming
isClassWithNameXM2

"The class ?Class is named ?ClassName.
CASE 1:?ClassName is bound"

?Class isClassWithName: +?ClassName if 
	[MLI current classesFor: ?ClassName asString] contains: ?Class.

"The class ?Class is named ?ClassName.
CASE 2:?ClassName is not bound"

?Class isClassWithName: -?ClassName if 
	?Class isClass,?ClassName equals: [MLI current classNameOf: ?Class]