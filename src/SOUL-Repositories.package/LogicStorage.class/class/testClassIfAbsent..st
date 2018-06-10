test classes
testClassIfAbsent: absentBlock
	
	^self
		testClassNamed: self name , 'Tests'
		ifAbsent: absentBlock