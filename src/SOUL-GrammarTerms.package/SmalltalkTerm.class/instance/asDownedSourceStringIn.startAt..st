printing
asDownedSourceStringIn: anEnv startAt: anIndex
	
	| variableValues downedSource |
	variableValues := self variables
		collect: [:aVariable | aVariable soulDownIn: anEnv startAt: anIndex].
	downedSource := source copy.
	self variables
		doWithIndex:
			[:aVariable :index | 
			downedSource := downedSource
				copyReplaceAll: '?' , aVariable name
				with: (variableValues at: index) displayString].
	^downedSource