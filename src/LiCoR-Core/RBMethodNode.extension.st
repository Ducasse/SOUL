Extension { #name : #RBMethodNode }

{ #category : #'*LiCoR-Core' }
RBMethodNode >> buildSignature [
	
	| sourceCode keywords aSelector argumentNames |
	aSelector := self selector.
	argumentNames := self argumentNames.
	aSelector isUnary
		ifTrue: [sourceCode := aSelector asString]
		ifFalse:
			[aSelector isInfix
				ifTrue: [sourceCode := aSelector asString , ' ' , argumentNames first]
				ifFalse:
					[keywords := aSelector keywords.
					sourceCode := ''.
					1
						to: keywords size
						do:
							[:n | 
							| keyword |
							keyword := keywords at: n.
							sourceCode := sourceCode , keyword , ' ' , (argumentNames at: n) ,
									' ']]].
	^sourceCode trimBlanks
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> method [
	
	^method
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> method: anObject [
	
	method := anObject
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> soulChildren [
	
	^OrderedCollection
		with: self selector
		with: self arguments
		with: self body
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> soulChildren: children [
	
	self selector: (children at: 1).
	self arguments: (children at: 2).
	self body: (children at: 3)
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	"GENERATED BY UNIFICATION EDITOR - DO NOT EDIT MANUALLY !!"

	
	^aTerm
		unifyWithRBMethodNode: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: aBool not
]

{ #category : #'*LiCoR-Core' }
RBMethodNode >> unifyWithRBMethodNode: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: aBool [
	^self = aTerm
]