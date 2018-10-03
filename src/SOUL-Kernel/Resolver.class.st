Class {
	#name : #Resolver,
	#superclass : #Object,
	#instVars : [
		'clause',
		'delayedClauses',
		'clauseIndex',
		'env',
		'startIndex'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
Resolver class >> fromClause: aClause toClauses: aSetOfClauses inEnv: anEnv startAt: anIndex [
	
	^self new fromClause: aClause toClauses: aSetOfClauses inEnv: anEnv
		startAt: anIndex
]

{ #category : #printing }
Resolver >> displayString [
	
	^'EXPAND(' , clause displayString , ')'
]

{ #category : #initialize }
Resolver >> fromClause: aClause toClauses: aSetOfClauses inEnv: anEnv startAt: anIndex [
	
	clause := aClause.
	clauseIndex := 1.
	delayedClauses := aSetOfClauses.
	env := anEnv.
	startIndex := anIndex
]

{ #category : #access }
Resolver >> isEmpty [
	
	^clauseIndex > delayedClauses size
]

{ #category : #access }
Resolver >> nextResolution [
	"Fetch the next candidate clause. start the transaction on the  
	environment. resolve the clause and the candidate clause. Bindings are  
	created in the environment as a side-effect of unification. On succes,  
	commit the bindings to the environment, otherwise perform a rollback.  
	The result is a resolution, containing the new conditions and the  
	backtrack-index in the environment"

	
	| result currentHornClause targetSource hisIndex |
	[result isNil & (clauseIndex <= delayedClauses size)]
		whileTrue:
			[currentHornClause := delayedClauses at: clauseIndex.
			clauseIndex := clauseIndex + 1.
			targetSource := currentHornClause conclusion innerTerm.
			hisIndex := env startUnifyWith: currentHornClause.
			(clause
				unifyWith: targetSource term
				inEnv: env
				myIndex: startIndex
				hisIndex: hisIndex
				inSource: true)
				ifTrue:
					[result := ResolutionResult
						condition: currentHornClause condition
						rollbackInfo: env rollbackInfo
						conditionsEnvIndex: hisIndex
						cutState: currentHornClause containsCut]
				ifFalse: [env rollback]].
	^result
]

{ #category : #printing }
Resolver >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' <'.
	clauseIndex printOn: aStream.
	aStream nextPut: $/.
	delayedClauses size printOn: aStream.
	aStream nextPut: $>
]
