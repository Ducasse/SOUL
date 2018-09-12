public access
parseMethod

	| fromSuper |
	fromSuper := super parseMethod.
	
	(RBReadBeforeWrittenTester variablesReadBeforeWrittenIn: fromSuper)
		do:
			[:temp | 
			fromSuper body
				addNodeFirst:
					(RBParser parseExpression: temp , ' := UninitializedTemporary new.')].
				
	^ fromSuper