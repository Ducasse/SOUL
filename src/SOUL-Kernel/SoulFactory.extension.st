Extension { #name : #SoulFactory }

{ #category : #'*SOUL-Kernel' }
SoulFactory class >> evaluator: aString [
	
	^Soul at: aString
]

{ #category : #'*SOUL-Kernel' }
SoulFactory class >> evaluators [
	
	^SoulEvaluator withAllSubclasses collect: [:e | e name]
]
