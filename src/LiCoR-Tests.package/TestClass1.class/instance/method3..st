protocol2
method3: arg
	
	^self method1
		ifTrue: [arg first]
		ifFalse: [arg asSet]