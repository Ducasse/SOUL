binary relations
isMetaClassOfXM2

"?MetaClass isMetaClassOf: ?Class verifies whether ?MetaClass is the Smalltalk metaclass
	 of ?Class. It works for ?MetaClass and ?Class bound or variable"

?MetaClass isMetaClassOf: ?Class if 
	?Class isClass,?MetaClass equals: [MLI forSmalltalk metaClassOf: ?Class]