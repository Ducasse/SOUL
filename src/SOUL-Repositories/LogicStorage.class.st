"
The main purpose of LogicStorage and its subclasses is to serve as storage for the source of SOUL programs in a format that can be easily written to disk and especially stored on a Store facility. A Store database can only be used to hold classes and methods and can not be easily extended to allow for other kinds of data, hence we map SOUL programs onto a representation that Store understands: classes and methods. LogicStorage classes are not directly used by the evaluation to lookup rules and facts, see LogicRepository for that.

SOUL programs are organized into 'layers', each LogicStorage subclass represents one such layer.

The instance methods of a LogicStorage subclass are simply used to hold the source of the program, the class methods of LogicStorage provide a clean way of accessing and modifying the parsed representation of these programs. The parsed representation is contained in the clausesStore class instance variable.

Each instance method holds the source for all the rules and facts in the layer that implement the same predicate. The name of this method is derived from the name of the predicate. The methods are kept in two-way sync with the parsed representation, when one changes the other is updated as well.

The methods in the following protocols provide the clean interface for accessing and editing the parsed representation:

- 'accessing' provides methods to retrieve the clauses in the layer
- 'editing' provides ways for adding, removing, replacing and changing the order of the clauses in the program
- 'protocol support' provides ways of organizing the predicates contained in the layer into protocols

[ TODO: 'editing' relies on identity of clauses, err what else? ]



"
Class {
	#name : #LogicStorage,
	#superclass : #Object,
	#classVars : [
		'StorageDependents'
	],
	#classInstVars : [
		'selectorToPredicateKey',
		'doingInternalStorage',
		'clausesStore'
	],
	#category : 'SOUL-Repositories'
}

{ #category : #'protocol support' }
LogicStorage class >> addProtocol: aSymbol [
	"asSymbol just to be sure"

	
	self organization addCategory: aSymbol asSymbol
]

{ #category : #'update mechanism' }
LogicStorage class >> addStorageDependentClass: aClass [
	
	(self storageDependents includes: aClass)
		ifFalse: [self storageDependents add: aClass]
]

{ #category : #'compilation support' }
LogicStorage class >> addSubclass: aSubclass [
	
	| res |
	res := super addSubclass: aSubclass.
	self notifyLayerAdd: aSubclass.
	^res
]

{ #category : #'accessing-all' }
LogicStorage class >> allClauses [
	"Return all clauses in this layer and all sublayers"

	
	| collection |
	collection := self gatherClauses.
	self allSubclasses do: [:cl | collection addAll: cl gatherClauses].
	^collection
]

{ #category : #'accessing-all' }
LogicStorage class >> allPredicateKeys [
	"Return all predicatekeys in this layer and all sublayers"

	
	| collection |
	collection := self predicateKeys.
	self allSubclasses do: [:cl | collection addAll: cl predicateKeys].
	^collection
]

{ #category : #'accessing-all' }
LogicStorage class >> allPredicateKeysIn: protocol [
	"Return all predicatekeys in this layer and all sublayers"

	
	| collection |
	collection := (self predicateKeysIn: protocol) asOrderedCollection.
	self subclasses
		do: [:cl | collection addAll: (cl allPredicateKeysIn: protocol)].
	^collection
]

{ #category : #'protocol support' }
LogicStorage class >> allProtocols [
	
	| collection |
	collection := Set new.
	collection addAll: self protocols.
	self subclasses do: [:class | collection addAll: class allProtocols].
	^collection
]

{ #category : #'editing-local' }
LogicStorage class >> assertClause: clause [
	
	^self
		assertClause: clause
		inProtocol: self defaultProtocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]
]

{ #category : #'editing-local' }
LogicStorage class >> assertClause: clause inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock [
	
	^self
		assertClauses: (OrderedCollection with: clause)
		inProtocol: protocol
		ifAlreadyClassified: alreadyClassifiedBlock
]

{ #category : #'editing-local' }
LogicStorage class >> assertClauses: clauses [
	
	^self
		assertClauses: clauses
		inProtocol: self defaultProtocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]
]

{ #category : #'editing-local' }
LogicStorage class >> assertClauses: clauses inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock [
	
	| keys |
	keys := OrderedCollection new.
	clauses
		do:
			[:clause | 
			| key |
			key := self predicateKeyofClause: clause.
			(self clausesCollectionForKey: key) add: clause.
			keys add: key].
	keys
		do:
			[:key | 
			self classifyPredicate: key under: protocol ifAlreadyClassified:
					alreadyClassifiedBlock.
			self storeClausesWithPredicateKey: key]
]

{ #category : #icon }
LogicStorage class >> browserIcon [
	
	^nil
]

{ #category : #'protocol support' }
LogicStorage class >> classifyPredicate: key under: protocol ifAlreadyClassified: alreadyClassifiedBlock [
	
	| current |
	current := self protocolOfPredicate: key.
	current
		ifNil: [self movePredicateKey: key toProtocol: protocol]
		ifNotNil:
			[current = protocol
				ifFalse:
					[(alreadyClassifiedBlock value: key value: current value: protocol)
						ifTrue: [self movePredicateKey: key toProtocol: protocol]]]
]

{ #category : #'private - storage' }
LogicStorage class >> clausesCollectionForKey: key [
	
	^self clausesStore
		at: key
		ifAbsentPut: [OrderedCollection new]
]

{ #category : #'accessing-all' }
LogicStorage class >> clausesForPredicateKey: predicateKey [
	
	| clauses |
	"returns the clauses that are defined for the given predicatekey, in this layer and all sublayers"

	clauses := OrderedCollection new.
	clauses
		addAll:
			(self clausesStore
				at: predicateKey
				ifAbsent: [OrderedCollection new]).
	self subclasses
		do:
			[:subclass | clauses addAll: (subclass clausesForPredicateKey: predicateKey)].
	^clauses
]

{ #category : #'private - storage' }
LogicStorage class >> clausesStore [
	
	clausesStore ifNil: [self initClausesStore].
	^clausesStore
]

{ #category : #'accessing-all' }
LogicStorage class >> collectPredicateNamesMatching: pattern [
	
	| result |
	result := (self predicateKeys asOrderedCollection
		select: [:namex | pattern match: namex])
		collect: [:namex | Association key: self value: namex].
	self subclasses
		do:
			[:subclass | result addAll: (subclass collectPredicateNamesMatching: pattern)].
	^result
]

{ #category : #'compilation support' }
LogicStorage class >> compilerClass [
	
	^SoulMethodCompiler
]

{ #category : #'accessing-local' }
LogicStorage class >> containsClause: clause [
	
	^self gatherClauses includes: clause
]

{ #category : #'storage-conversion' }
LogicStorage class >> copyFromLayerWithOldStorageSystem: oldLayer [
	"This method can be used to convert layers that are still stored using one
	of the old storage systems or that were edited directly using the class
	browser rather than the clause browser. It is best to make a new layer first,
	and then send it this message using the old layer as the argument."

	
	| clauses |
	oldLayer organization categories
		do:
			[:eachCategory | 
			(oldLayer organization listAtCategoryNamed: eachCategory)
				do:
					[:selector | 
					clauses := oldLayer new perform: selector.
					self
						assertClauses: clauses
						inProtocol: eachCategory
						ifAlreadyClassified: [:predicate :oldProtocol :newProtocol | false]]]
]

{ #category : #repositories }
LogicStorage class >> createAnonymousRepository [
	
	| rep |
	rep := SoulFactory current makeRepository new loadLayer: self.
	self allSubclasses do: [:cl | rep loadLayer: cl].
	^rep
]

{ #category : #'private - storage' }
LogicStorage class >> defaultProtocol [
	
	^ClassOrganizer defaultProtocol
]

{ #category : #'private - storage' }
LogicStorage class >> deleteStorageOfClausesWithPredicateKey: key [
	
	| selector |
	selector := self selectorForPredicateKey: key.
	self removeSelector: selector
]

{ #category : #'private - storage' }
LogicStorage class >> doingInternalStorage [
	
	^doingInternalStorage
		ifNil: [false]
		ifNotNil: [doingInternalStorage]
]

{ #category : #'private - storage' }
LogicStorage class >> doingInternalStorage: newSettingBoolean [
	
	doingInternalStorage := newSettingBoolean
]

{ #category : #'signal constants' }
LogicStorage class >> errorSignal [
	
	^SoulError
]

{ #category : #'private - storage' }
LogicStorage class >> gatherClauses [
	
	| result |
	result := OrderedCollection new.
	self clausesStore values do: [:clauses | result addAll: clauses].
	^result
]

{ #category : #'editing-all' }
LogicStorage class >> inAllRename: originalName multiplicity: multiplicity to: newName argumentMapping: argumentMapping [
	
	self rename: originalName multiplicity: multiplicity to: newName
		argumentMapping: argumentMapping.
	self allSubclasses
		do:
			[:layer | 
			layer rename: originalName multiplicity: multiplicity to: newName
				argumentMapping: argumentMapping]
]

{ #category : #initialize }
LogicStorage class >> initAllPredicateMappings [
	"recursively construct the table of selector -> predicates mappings. this is used by the clause browser"

	
	self initPredicateMappings.
	self subclasses do: [:subclass | subclass initAllPredicateMappings]
]

{ #category : #initialize }
LogicStorage class >> initClausesStore [
	
	clausesStore := Dictionary new
]

{ #category : #initialize }
LogicStorage class >> initPredicateMappings [
	
	| clause |
	"construct the table of selector -> predicates mappings. this is used by the clause browser"

	selectorToPredicateKey := Dictionary new.
	self selectors
		do:
			[:sel | 
			clause := (self new perform: sel) clauses first.
			selectorToPredicateKey
				at: sel
				put: (self predicateKeyofClause: clause)]
]

{ #category : #initialize }
LogicStorage class >> initialize [
	
	self initPredicateMappings.
	self initClausesStore
]

{ #category : #'accessing-all' }
LogicStorage class >> layerContainingClause: clause ifNone: noneBlock [
	
	| coll |
	coll := OrderedCollection with: self.
	coll addAll: self allSubclasses.
	^coll
		detect: [:layer | layer containsClause: clause]
		ifNone: noneBlock
]

{ #category : #'private - predicate keys' }
LogicStorage class >> makePredicateKey: aPredicate multiplicity: aMult [
	
	^aMult < 0
		ifTrue: [aPredicate , '@']
		ifFalse: [aPredicate , '/' , aMult asString]
]

{ #category : #'editing-local' }
LogicStorage class >> moveClauseDown: clause [
	
	| key index |
	key := self predicateKeyofClause: clause.
	index := (self clausesCollectionForKey: key)
		indexOf: clause
		ifAbsent:
			[self error: 'Trying to move a clause in a layer that does not contain it.'].
	(self clausesCollectionForKey: key) size > index
		ifTrue:
			[(self clausesCollectionForKey: key)
				swap: index
				with: index + 1.
			self storeClausesWithPredicateKey: key]
]

{ #category : #'editing-local' }
LogicStorage class >> moveClauseUp: clause [
	
	| key index |
	key := self predicateKeyofClause: clause.
	index := (self clausesCollectionForKey: key)
		indexOf: clause
		ifAbsent:
			[self error: 'Trying to move a clause in a layer that does not contain it.'].
	index > 1
		ifTrue:
			[(self clausesCollectionForKey: key)
				swap: index
				with: index - 1.
			self storeClausesWithPredicateKey: key]
]

{ #category : #'protocol support' }
LogicStorage class >> movePredicateKey: key toProtocol: protocol [
	"returns true if successful, to see if we need to refresh any views"

	
	| selector org oldProtocol |
	selector := self selectorForPredicateKey: key.
	org := self organization.	"The below code is cleaner, but Store does not notice anything has changed when we do this."
	"TODO: Make the store notice!"

	org := self organization.
	oldProtocol := org categoryOfElement: selector.
	oldProtocol = protocol
		ifFalse:
			[org removeElement: selector.
			org classify: selector under: protocol.
			^true].
	^false
]

{ #category : #'private - predicate keys' }
LogicStorage class >> multiplicityOfKey: aPredicateKey [
	
	| splitIndex multString |
	splitIndex := aPredicateKey indexOf: $/.
	multString := aPredicateKey
		copyFrom: splitIndex + 1
		to: aPredicateKey size.
	^multString asNumber
]

{ #category : #'update mechanism' }
LogicStorage class >> notifyImplementationChange [
	
	self storageDependents
		do:
			[:class | 
			class withAllSubclasses
				do:
					[:aclass | aclass allInstancesDo: [:e | e update: #changePredicate with: self]]]
]

{ #category : #'update mechanism' }
LogicStorage class >> notifyLayerAdd: aClass [
	
	self storageDependents
		do:
			[:class | class allInstances do: [:e | e update: #addLayer with: aClass]]
]

{ #category : #'update mechanism' }
LogicStorage class >> notifyLayerRemove: aClass [
	
	self storageDependents
		do:
			[:class | class allInstances do: [:e | e update: #removeLayer with: aClass]]
]

{ #category : #'private - storage' }
LogicStorage class >> parseInstanceStorageMethod: selector [
	
	^SoulFactory current makeParser
		parseAfterRemovingSelector: (self sourceCodeAt: selector)
]

{ #category : #'private - predicate keys' }
LogicStorage class >> predicateKeyofClause: aClause [
	
	^self
		makePredicateKey: aClause predicate
		multiplicity: aClause multiplicity
]

{ #category : #'accessing-local' }
LogicStorage class >> predicateKeys [
	"return all predicatekeys in this layer"

	
	^self selectorToPredicateKeyMapping values
]

{ #category : #'accessing-local' }
LogicStorage class >> predicateKeysIn: protocol [
	
	| mapping |
	mapping := self selectorToPredicateKeyMapping.
	^(self organization listAtCategoryNamed: protocol)
		collect: [:selector | mapping at: selector]
]

{ #category : #'test classes' }
LogicStorage class >> predicateKeysWithoutTestCases [
	
	| missingTestKeys |
	missingTestKeys := OrderedCollection new.
	self predicateKeys
		do:
			[:key | 
			self
				testMethodForPredicateKey: key
				ifAbsent: [missingTestKeys add: key]].
	^missingTestKeys
]

{ #category : #'private - predicate keys' }
LogicStorage class >> predicateOfKey: aPredicateKey [
	
	^aPredicateKey copyUpTo: $/
]

{ #category : #'private - storage' }
LogicStorage class >> printClausesWithKey: key [
	
	| printStream |
	printStream := WriteStream on: String new.
	printStream
		cr;
		cr.
	(self clausesCollectionForKey: key)
		do: [:cl | cl printOn: printStream]
		separatedBy:
			[printStream
				write: '.';
				cr;
				cr].
	^printStream contents
]

{ #category : #'protocol support' }
LogicStorage class >> protocolOfPredicate: aString [
	
	| selector org |
	selector := self selectorForPredicateKey: aString.
	org := self organization.
	^org categoryOfElement: selector
]

{ #category : #'protocol support' }
LogicStorage class >> protocols [
	
	^self organization categories
]

{ #category : #'private - storage' }
LogicStorage class >> reReadAllStorage [
	
	self reReadFromStorage.
	self subclasses do: [:class | class reReadAllStorage]
]

{ #category : #'private - storage' }
LogicStorage class >> reReadFromStorage [
	
	| dummyInstance clauses key |
	dummyInstance := self new.
	self initClausesStore.
	self initPredicateMappings.
	self selectors
		do:
			[:selector | 
			clauses := (dummyInstance perform: selector) clauses.
			key := self predicateKeyofClause: clauses first.
			self clausesStore at: key put: clauses.
			self selectorToPredicateKeyMapping at: selector put: key].
	self notifyImplementationChange
]

{ #category : #'compilation support' }
LogicStorage class >> recompileAll [
	
	self recompileSelectors.
	self subclasses do: [:subclass | subclass recompileAll]
]

{ #category : #'compilation support' }
LogicStorage class >> recompileSelectors [
	
	self selectors do: [:selector | self recompile: selector]
]

{ #category : #'protocol support' }
LogicStorage class >> removeProtocol: protocolName [
	
	(self predicateKeysIn: protocolName asSymbol)
		do: [:predicateKey | self retractClausesWithPredicateKey: predicateKey].
	self organization removeCategory: protocolName asSymbol
]

{ #category : #'compilation support' }
LogicStorage class >> removeSelector: sel [
	
	| res |
	self clausesStore removeKey: (selectorToPredicateKey at: sel).
	selectorToPredicateKey
		removeKey: sel
		ifAbsent: [].
	res := super removeSelector: sel.
	self notifyImplementationChange.
	^res
]

{ #category : #'update mechanism' }
LogicStorage class >> removeStorageDependentClass: aClass [
	
	self storageDependents remove: aClass
]

{ #category : #'compilation support' }
LogicStorage class >> removeSubclass: aSubclass [
	
	| res |
	res := super removeSubclass: aSubclass.
	self notifyLayerRemove: aSubclass.
	^res
]

{ #category : #'editing-local' }
LogicStorage class >> rename: renamed multiplicity: multiplicity to: newName argumentMapping: argumentMapping [
	
	| renameVisitor newClause |
	renameVisitor := CompoundTermRenamingVisitor rename: renamed multiplicity:
			multiplicity to: newName argumentMapping: argumentMapping.
	self gatherClauses
		do:
			[:clause | 
			newClause := clause accept: renameVisitor.
			renameVisitor didRenaming
				ifTrue: [self replaceClause: clause with: newClause].
			renameVisitor resetDidRenaming]
]

{ #category : #'protocol support' }
LogicStorage class >> renameProtocol: oldName to: newName [
	"asSymbol just to be sure"

	
	self organization
		renameCategory: oldName asSymbol
		to: newName asSymbol
]

{ #category : #'editing-local' }
LogicStorage class >> replaceClause: original with: replacement [
	
	^self
		replaceClause: original
		with: replacement
		inProtocol:
			(self protocolOfPredicate: (self predicateKeyofClause: original))
]

{ #category : #'editing-local' }
LogicStorage class >> replaceClause: original with: replacement inProtocol: protocol [
	
	^self
		replaceClause: original
		with: replacement
		inProtocol: protocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]
]

{ #category : #'editing-local' }
LogicStorage class >> replaceClause: original with: replacement inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock [
	
	| keyOriginal keyReplacement indexOriginal |
	keyOriginal := self predicateKeyofClause: original.
	keyReplacement := self predicateKeyofClause: replacement.
	keyOriginal = keyReplacement
		ifTrue:
			[indexOriginal := (self clausesCollectionForKey: keyOriginal)
				indexOf: original
				ifAbsent:
					[self error:
							'Trying to replace a clause in a layer which does not contain it.'].
			(self clausesCollectionForKey: keyOriginal) at: indexOriginal put:
					replacement.
			self storeClausesWithPredicateKey: keyOriginal]
		ifFalse:
			[self retractClause: original.
			self assertClause: replacement inProtocol: protocol ifAlreadyClassified:
					alreadyClassifiedBlock]
]

{ #category : #'editing-local' }
LogicStorage class >> retractClause: clause [
	
	| key |
	key := self predicateKeyofClause: clause.
	(self clausesCollectionForKey: key)
		remove: clause
		ifAbsent:
			[self error:
					'Trying to remove a clause from a layer that does not contain it.'].
	self storeClausesWithPredicateKey: key
]

{ #category : #'editing-local' }
LogicStorage class >> retractClausesWithPredicateKey: key [
	
	self deleteStorageOfClausesWithPredicateKey: key
]

{ #category : #'private - storage' }
LogicStorage class >> selectorForPredicateKey: aKey [
	
	^((((aKey copyReplaceAll: ':' with: 'X') copyReplaceAll: '/' with: 'M')
		copyReplaceAll: '=' with: 'E') copyReplaceAll: '@' with: 'Q') asSymbol
]

{ #category : #'private - storage' }
LogicStorage class >> selectorToPredicateKeyMapping [
	
	selectorToPredicateKey == nil ifTrue: [self initPredicateMappings].
	^selectorToPredicateKey
]

{ #category : #'private - storage' }
LogicStorage class >> storageChangedExternally: selector newCode: aCode [
	
	| clauses key |
	clauses := (SoulFactory current makeParser parseAfterRemovingSelector: aCode)
		clauses.
	key := self predicateKeyofClause: clauses first.
	self clausesStore at: key put: clauses.
	self selectorToPredicateKeyMapping at: selector put: key.
	self notifyImplementationChange
]

{ #category : #'private - storage' }
LogicStorage class >> storageDependents [
	
	StorageDependents ifNil: [StorageDependents := OrderedCollection new].
	^StorageDependents
]

{ #category : #'private - storage' }
LogicStorage class >> storeClausesWithPredicateKey: key [
	
	| source selector |
	self doingInternalStorage: true.
	[(self clausesCollectionForKey: key) isEmpty
		ifTrue: [self deleteStorageOfClausesWithPredicateKey: key]
		ifFalse:
			[selector := self selectorForPredicateKey: key.
			source := selector , (self printClausesWithKey: key).
			self compile: source.
			self selectorToPredicateKeyMapping at: selector put: key.
			self notifyImplementationChange]]
		ensure: [self doingInternalStorage: false]
]

{ #category : #'editing-local' }
LogicStorage class >> swapClause: clauseA with: clauseB [
	
	| key indexA indexB |
	key := self predicateKeyofClause: clauseA.
	(self predicateKeyofClause: clauseB) = key
		ifFalse:
			[self error:
					'Trying to swap two clauses which do not implement the same predicate.'].
	indexA := (self clausesCollectionForKey: key)
		indexOf: clauseA
		ifAbsent:
			[self error: 'Trying to swap two clauses not in the same layer. '].
	indexB := (self clausesCollectionForKey: key)
		indexOf: clauseB
		ifAbsent:
			[self error: 'Trying to swap two clauses not in the same layer. '].
	(self clausesCollectionForKey: key) swap: indexA with: indexB.
	self storeClausesWithPredicateKey: key
]

{ #category : #'test classes' }
LogicStorage class >> testClassIfAbsent: absentBlock [
	
	^self
		testClassNamed: self name , 'Tests'
		ifAbsent: absentBlock
]

{ #category : #'test classes' }
LogicStorage class >> testClassNamed: testClassName ifAbsent: absentBlock [
	
	SoulTests at: testClassName ifAbsent: absentBlock
]

{ #category : #'test classes' }
LogicStorage class >> testMethodForPredicateKey: key ifAbsent: absentBlock [
	
	| testSelector testClass |
	testSelector := 'test'
		, ((key copyReplaceAll: '/' with: '') copyReplaceAll: ':' with: '_').
	testClass := self testClassIfAbsent: [^absentBlock value].
	^testClass methodDictionary at: testSelector ifAbsent: absentBlock
]

{ #category : #private }
LogicStorage class >> usersOfPredicate: pred multiplicity: mult [
	
	^self gatherClauses
		select: [:clause | clause usesPredicate: pred multiplicity: mult]
]

{ #category : #'accessing-all' }
LogicStorage class >> usersOfPredicateKey: aPredicateKey [
	
	| pred mult result |
	pred := self predicateOfKey: aPredicateKey.
	mult := self multiplicityOfKey: aPredicateKey.
	result := self usersOfPredicate: pred multiplicity: mult.
	self allSubclasses
		do:
			[:layer | result addAll: (layer usersOfPredicate: pred multiplicity: mult)].
	^result
]
