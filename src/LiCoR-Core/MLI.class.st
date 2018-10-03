Class {
	#name : #MLI,
	#superclass : #Object,
	#classVars : [
		'RunningMLIs'
	],
	#category : 'LiCoR-Core'
}

{ #category : #deprecated }
MLI class >> current [
	"DEPRECATED"
	"returns the current Meta-Level Interface to be used. This can be 
	changed using the #setCurrentMLI: method"
	^ self getMLIFor: #Smalltalk
]

{ #category : #convenience }
MLI class >> forSmalltalk [
	^ self getMLIFor: #Smalltalk
]

{ #category : #MLIs }
MLI class >> getMLIFor: aLanguage [
	^ RunningMLIs at: aLanguage ifAbsent:[self error: aLanguage,' is not installed in the MLI']
]

{ #category : #'initialize-release' }
MLI class >> initialize [
	RunningMLIs := Dictionary new
]

{ #category : #deprecated }
MLI class >> setAsCurrentMLI [
	^ self setCurrentMLI: self new
]

{ #category : #MLIs }
MLI class >> setAsMLIFor: aLanguage [
	^ self setMLI: self new for: aLanguage
]

{ #category : #deprecated }
MLI class >> setCurrentMLI: anExplicitMLI [ 
	self setMLI: anExplicitMLI for: #Smalltalk
]

{ #category : #MLIs }
MLI class >> setMLI: anMLI for: aLanguage [
	^ RunningMLIs at: aLanguage put: anMLI
]
