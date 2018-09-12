traversal
otherComplexWith: aString
	
	| compiler method mclass env newString |
	compiler := self compilerClass new.
	self namedReferent isBehavior
		ifTrue:
			[mclass := self namedReferent.
			env := mclass environment]
		ifFalse:
			[mclass := nil class.
			env := self namedReferent].
	method := compiler
		methodClass: compiler methodClassForInitializers;
		allowClassVariableReferences: mclass == self namedReferent;
		compile: (newString := aString copy)
			in: nil
			allowReceiver: false
			class: mclass
			environment: env
			noPattern: true
			notifying: nil
			ifFail: [self error: 'Can''t complete compilation of this initializer'].
	method containingEnvironment: self namedReferent.
	(newString := newString copy)
		nextPut: 'foo';
		nextPut: 'bar';
		nextPut: 'zork'.
	^BlockClosure newCleanMethod: method