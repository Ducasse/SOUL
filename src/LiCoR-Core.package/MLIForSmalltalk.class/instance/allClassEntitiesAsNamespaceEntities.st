private
allClassEntitiesAsNamespaceEntities
	
	^self allClassEntities collect: [:class | class asNameSpace]