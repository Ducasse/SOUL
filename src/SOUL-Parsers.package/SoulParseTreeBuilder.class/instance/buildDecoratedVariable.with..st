building SmalltalkTerm/QuotedCode
buildDecoratedVariable: aName with: aCollectionOfConstants
	
	^(DecoratedVariable name: (aName allButFirst: 1)) decorators:
			aCollectionOfConstants