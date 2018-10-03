Class {
	#name : #FailFrame,
	#superclass : #Frame,
	#category : 'SOUL-Kernel'
}

{ #category : #printing }
FailFrame >> displayString [
	
	^'fail'
]

{ #category : #access }
FailFrame >> isEmpty [
	
	^true
]

{ #category : #evaluation }
FailFrame >> resolveIn: anEnv [
	
	^false
]

{ #category : #access }
FailFrame >> resultOf: vars in: env startAt: startIndex [
	
	^false
]
