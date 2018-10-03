"
Timing information can be gathered while running the QSoul unit tests. This class implements the timing notifications that are sent by the tests (by virtue of the class QSOULLogicTests). Subclasses can override this to calculate sums, display information, save information, etc.
"
Class {
	#name : #LogicTestNotifier,
	#superclass : #Object,
	#instVars : [
		'outputStream'
	],
	#category : 'SOUL-Tests'
}

{ #category : #'Instance Creation' }
LogicTestNotifier class >> outputStream: aStream [
	"Set the outputStream to use. When none is provided; the Transcript is used."

	
	^self new outputStream: aStream
]

{ #category : #Public }
LogicTestNotifier class >> useAsTimer [
	"Set the current Timer as the current one to use by LogicTests."

	
	LogicTests setLogicTimer: self new
]

{ #category : #'Test Interface' }
LogicTestNotifier >> afterCaseDo: aTestCase [
	"Action to take after the case is being run."

	"By default do nothing."
	
	
]

{ #category : #'Test Interface' }
LogicTestNotifier >> afterQuery: results description: descriptionString [
	"A query was run, with as description the given string. The results are in 'results'."

	"By default do nothing."
	
	
]

{ #category : #'Test Interface' }
LogicTestNotifier >> beforeCaseDo: aTestCase [
	"Action to take before the case is being run."

	"By default do nothing."
	
	
]

{ #category : #'Test Interface' }
LogicTestNotifier >> beforeQuery: aString [
	"A query will be run (with the code given by aString)."

	"By default do nothing."
	
	
]

{ #category : #'Private-accessing' }
LogicTestNotifier >> outputStream [
	
	outputStream isNil ifTrue: [outputStream := Transcript].
	^outputStream
]

{ #category : #'Private-accessing' }
LogicTestNotifier >> outputStream: aStream [
	
	outputStream := aStream
]
