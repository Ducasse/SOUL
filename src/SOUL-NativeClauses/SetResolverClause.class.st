Class {
	#name : #SetResolverClause,
	#superclass : #NativeClause,
	#category : 'SOUL-NativeClauses'
}

{ #category : #access }
SetResolverClause >> argsIn: anEnv startAt: anIndex [
	
	^(header terms at: 2) soulDownIn: anEnv startAt: anIndex
]

{ #category : #access }
SetResolverClause >> blockIn: anEnv startAt: anIndex [
	
	^header terms first soulDownIn: anEnv startAt: anIndex
]

{ #category : #resolving }
SetResolverClause >> resolveIn: env startAt: anIndex [
	
	| args block |
	block := self blockIn: env startAt: anIndex.
	args := self argsIn: env startAt: anIndex.
	^NativeResolver onBlock: block withArguments: args
]
