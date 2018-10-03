Class {
	#name : #ResolutionResult,
	#superclass : #Object,
	#instVars : [
		'conditions',
		'rollbackInfo',
		'conditionsEnvIndex',
		'cutTopDelimiter'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
ResolutionResult class >> condition: aCondition rollbackInfo: aRollbackInfo conditionsEnvIndex: condIndex cutState: cutState [
	
	^self new condition: aCondition rollbackInfo: aRollbackInfo
		conditionsEnvIndex: condIndex cutState: cutState
]

{ #category : #initialize }
ResolutionResult >> condition: aCondition rollbackInfo: aRollbackInfo conditionsEnvIndex: condIndex cutState: cutState [
	
	conditions := aCondition.
	rollbackInfo := aRollbackInfo.
	conditionsEnvIndex := condIndex.
	cutTopDelimiter := cutState
]

{ #category : #access }
ResolutionResult >> conditions [
	
	^conditions
]

{ #category : #access }
ResolutionResult >> conditionsEnvIndex [
	
	^conditionsEnvIndex
]

{ #category : #access }
ResolutionResult >> cutTopDelimiter [
	
	^cutTopDelimiter
]

{ #category : #printing }
ResolutionResult >> printOn: aStream [
	
	aStream
		write: 'resolutionresult with conditions: ';
		cr.
	conditions printOn: aStream.
	aStream
		cr;
		write: ' and rollbackInfo: ';
		cr.
	rollbackInfo printOn: aStream.
	aStream cr
]

{ #category : #access }
ResolutionResult >> rollbackInfo [
	
	^rollbackInfo
]
