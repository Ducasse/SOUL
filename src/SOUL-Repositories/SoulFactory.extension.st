Extension { #name : #SoulFactory }

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> addRepositoriesDependent: aDependent [
	
	RepositoriesDependents add: aDependent
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> compilingRepository [
	
	| rep |
	^Repositories
		at: #compiling 
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			rep loadLayer: QuotedParseLayer.
			QuotedParseLayer allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: LogicPrimitives.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			self repository: #compiling put: rep.
			rep]
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> doAfterRepositoryLoad: aBlock [
	
	(Repositories at: #default) == nil
		ifTrue: [self addToWaitList: aBlock]
		ifFalse: [aBlock value]
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> initializeRepositories [
	"After loading Soul, this method will initialize the necessary repositories to ensure a correct working of the interpreter"

	
	self parsingRepository.
	self logicRepository.
	self testRepository.
	self transparentSymbiosisRepository
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> logicRepository [
	
	| rep |
	rep := Repositories
		at: #logic
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."

			rep].	"TO BE REMOVED IN LATER VERSIONS!"

	Repositories at: #default put: rep.
	^rep
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> notifyRepositoriesDependents [
	
	RepositoriesDependents do: [:each | each updateRepositories]
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> parsingRepository [
	
	| rep |
	^Repositories
		at: #parsing
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			rep loadLayer: QuotedParseLayer.
			QuotedParseLayer allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: LogicPrimitives.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			self repository: #parsing put: rep.
			rep]
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> removeRepositoriesDependent: aDependent [
	
	RepositoriesDependents
		remove: aDependent
		ifAbsent: []
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> removeRepository: aName [
	
	Repositories removeKey: aName.
	self notifyRepositoriesDependents
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> repositories [

	^ Repositories
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> repository: aName [
	
	aName = #logic ifTrue: [self logicRepository].	"aName = #default ifTrue:[ 	self defaultRepository ]."

	aName = #parsing ifTrue: [self parsingRepository].
	^Repositories at: aName
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> repository: aName put: aRepository [
	
	Repositories at: aName put: aRepository.
	aRepository name: aName.
	aRepository compile.
	self notifyRepositoriesDependents
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> repositoryNames [
	
	^Repositories keys
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> resetDefaultRepository [
	
	Repositories
		removeKey: #default
		ifAbsent: []
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> testRepository [
	
	
	^ Repositories 
		at: #test
		ifAbsentPut: [
			| rep |
			rep := SoulFactory current makeRepository new.
			LogicPrimitives allSubclasses do: [:cl | rep loadLayer: cl].
			rep loadLayer: TestQueriesLayer.
			TestQueriesLayer allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."
			rep ]
]

{ #category : #'*SOUL-Repositories' }
SoulFactory class >> transparentSymbiosisRepository [
	
	| rep |
	^Repositories
		at: #'transparant-symbiosis'
		ifAbsentPut:
			[rep := SoulFactory current makeRepository new.
			LogicStorage allSubclasses do: [:cl | rep loadLayer: cl].	"self processWaitList."

			rep]
]
