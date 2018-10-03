"
I walk a Soul parse tree and apply an action on every variable (both named and underscore variables) of that tree.
"
Class {
	#name : #VariableAndUnderscoreVariableVisitor,
	#superclass : #NamedVariableVisitor,
	#category : 'SOUL-Kernel'
}

{ #category : #'visiting terms' }
VariableAndUnderscoreVariableVisitor >> underscoreVariableVisit: aVariable [
	
	doBlock value: aVariable
]
