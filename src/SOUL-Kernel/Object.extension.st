Extension { #name : #Object }

{ #category : #'*SOUL-Kernel' }
Object >> accept: aVisitor [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> asSourceString [
	"This message gets send to an object if it is used inside a quotedcode. The result should be the textual representation of the object; as desired. Subclasses might 	want to override this message"

	
	| stream |
	stream := WriteStream on: String new.
	self printOn: stream.
	^stream contents
]

{ #category : #'*SOUL-Kernel' }
Object >> asSourceStringIn: anEnv startAt: index [
	"this necessary to make quotedcode work when some variables are already filled in, because of an earlier downing process"

	
	^self asSourceString
]

{ #category : #'*SOUL-Kernel' }
Object >> asString [
	"Answer a string that represents the receiver."

	"Squeak Compatibility"

	
	^self printString
]

{ #category : #'*SOUL-Kernel' }
Object >> explicitSoulUp [
	
	^self soulUp
]

{ #category : #'*SOUL-Kernel' }
Object >> isNumber [
	
	^false
]

{ #category : #'*SOUL-Kernel' }
Object >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	"Most object cannot be translated to Prolog. Rather than outputting an error though, we output a stub."

	
	aStream nextPutAll: 'object'
]

{ #category : #'*SOUL-Kernel' }
Object >> putOn: aStream [
	
	^aStream nextPut: self
]

{ #category : #'*SOUL-Kernel' }
Object >> soulDownIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #'*SOUL-Kernel' }
Object >> soulUp [
	
	^SoulFactory current makeUppedObject up: self
]

{ #category : #'*SOUL-Kernel' }
Object >> todo: msg [
	
	
]

{ #category : #'*SOUL-Kernel' }
Object >> ugly: msg [
	
	
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithDelayedVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithKeywordedCompound: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithNegVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithPosVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithTemplateQueryTerm: aTQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	self shouldNotImplement
]

{ #category : #'*SOUL-Kernel' }
Object >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self shouldNotImplement
]
