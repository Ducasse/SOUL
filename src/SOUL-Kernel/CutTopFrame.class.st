Class {
	#name : #CutTopFrame,
	#superclass : #Frame,
	#category : 'SOUL-Kernel'
}

{ #category : #testing }
CutTopFrame >> cuttop [
	
	^true
]

{ #category : #testing }
CutTopFrame >> isEmpty [
	
	^false
]

{ #category : #evaluation }
CutTopFrame >> resolveIn: anEnv [
	
	^OrderedCollection new
]
