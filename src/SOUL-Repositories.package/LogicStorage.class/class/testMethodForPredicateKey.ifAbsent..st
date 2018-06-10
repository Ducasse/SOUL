test classes
testMethodForPredicateKey: key ifAbsent: absentBlock
	
	| testSelector testClass |
	testSelector := 'test'
		, ((key copyReplaceAll: '/' with: '') copyReplaceAll: ':' with: '_').
	testClass := self testClassIfAbsent: [^absentBlock value].
	^testClass methodDictionary at: testSelector ifAbsent: absentBlock