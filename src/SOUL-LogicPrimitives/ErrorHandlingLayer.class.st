Class {
	#name : #ErrorHandlingLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
ErrorHandlingLayer >> errorM1 [

"Displays an error and immediately stops interpretation

SUnit test written (Roel, Jan 28, 2002)"

error(?errorString) if 
	[SoulRuntimeException signal: ('SOUL >> ' , ?errorString)]
]

{ #category : #'soul auto saved' }
ErrorHandlingLayer >> inspectTermM1 [

"SUnit test written (Roel, Jan 28, 2002)"

inspectTerm(?aTerm) if 
	[?aTerm inspect.
	self halt.
	true]
]
