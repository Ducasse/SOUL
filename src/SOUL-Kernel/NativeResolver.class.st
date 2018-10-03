Class {
	#name : #NativeResolver,
	#superclass : #Resolver,
	#instVars : [
		'block',
		'args',
		'pos',
		'argsSize'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
NativeResolver class >> onBlock: aBlock withArguments: args [
	
	^self new onBlock: aBlock withArguments: args
]

{ #category : #printing }
NativeResolver >> displayString [
	
	^'EXPAND(' , block displayString , ')'
]

{ #category : #access }
NativeResolver >> isEmpty [
	
	^pos >= argsSize
]

{ #category : #access }
NativeResolver >> nextResolution [
	
	pos := pos + 1.
	^block value: (args at: pos)
]

{ #category : #initialize }
NativeResolver >> onBlock: aBlock withArguments: anArgs [
	
	block := aBlock.
	args := anArgs.
	argsSize := args size.
	pos := 0
]
