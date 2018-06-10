compilation
compile: aCode in: aClass notifying: aRequestor ifFail: aFailBlock
	
	| method |
	method := RBParser parseMethod: aCode.
	(RBReadBeforeWrittenTester variablesReadBeforeWrittenIn: method)
		do:
			[:temp | 
			method body
				addNodeFirst:
					(RBParser parseExpression: temp , ' := UninitializedTemporary new.')].
	^super
		compile: method formattedCode
		in: aClass
		notifying: aRequestor
		ifFail: aFailBlock