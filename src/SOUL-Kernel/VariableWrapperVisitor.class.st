Class {
	#name : #VariableWrapperVisitor,
	#superclass : #CopyingVisitor,
	#category : 'SOUL-Kernel'
}

{ #category : #'visiting terms' }
VariableWrapperVisitor >> underscoreVariableVisit: aVariable [
	
	^Constant name: 'MetaVar' , aVariable name
]

{ #category : #'visiting terms' }
VariableWrapperVisitor >> variableVisit: aVariable [
	
	^Constant name: 'MetaVar' , aVariable name
]
