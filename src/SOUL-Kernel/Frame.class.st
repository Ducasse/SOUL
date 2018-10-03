Class {
	#name : #Frame,
	#superclass : #Object,
	#instVars : [
		'envRollbackInfo'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #access }
Frame >> cuttop [
	
	^false
]

{ #category : #access }
Frame >> isEmpty [
	
	^self subclassResponsibility
]

{ #category : #evaluation }
Frame >> resolveIn: anEnv [
	
	^self subclassResponsibility
]

{ #category : #access }
Frame >> resultOf: vars in: env startAt: startIndex [
	
	^self subclassResponsibility
]

{ #category : #evaluation }
Frame >> rollback: anEnv [
	
	anEnv rollbackTo: self rollbackInfo
]

{ #category : #access }
Frame >> rollbackInfo [
	
	^envRollbackInfo
]

{ #category : #access }
Frame >> rollbackInfo: aRollbackInfo [
	
	envRollbackInfo := aRollbackInfo
]
