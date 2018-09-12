naming
testIsClassWithName2
	"self run: #testclassWithName2"

	
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#Object],nonvar(?Class)))'
		description: 'Can we find a class with a given name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: Object,nonvar(?Class)))'
		description:
			'Can we find a class with a given name? (here we use the shortcut notation for symbols)'.
	self processQuery:
			' if succeeds(and([Object] isClassWithName: ?ClassName,nonvar(?ClassName)))'
		description: 'Can we retrieve the name of a given class?'.
	self processQuery: ' if succeeds([Object] isClassWithName: [#Object])'
		description: 'Can we verify whether a class has a given name?'.
	self processQuery: ' if succeeds([Object] isClassWithName: Object)'
		description:
			'Can we verify whether a class has a given name?  (here we use the shortcut notation for symbols)'.
	self processQuery:
			' if succeeds(one(and(?Class isClassWithName: ?ClassName,nonvar(?Class),nonvar(?ClassName))))'
		description: 'Can we retrieve a class and its name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#Object],nonvar(?Class),?Class equals: [Object]))'
		description:
			'Can we find a class with a given name and is it the correct class?'.
	self processQuery:
			' if succeeds(and([Object] isClassWithName: ?ClassName,nonvar(?ClassName),?ClassName equals: [#Object]))'
		description:
			'Can we find the name of a given class and is it the correct name?'.
	self processQuery:
			' if succeeds(and(?Class isClassWithName: [#''Object class''],nonvar(?Class)))'
		description: 'Can we find a meta class with a given name?'.
	self processQuery:
			' if succeeds(and([Object class] isClassWithName: ?ClassName,nonvar(?ClassName)))'
		description: 'Can we find the name of a given meta class?'.
	self processQuery:
			' if succeeds([Object class] isClassWithName: [#''Object class''])'
		description: 'Can we verify whether a meta class has a given name?'