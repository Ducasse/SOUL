"
LogicRepository represents a database of logic clauses that can be used by the Soul interpreter. It supports adding clauses from layers as well as adding new clauses that are not saved in a layer. 

Normally, the interpreter fetches the clauses by lexical address. This can be done because a repository can 'compile' his clauses to make repository access faster. Compilation of the repository simply means that all predicates in the repository are given a unique address, at which they can be found in the repository. The interpreter can thus easily and quickly access all necessary clauses.

Repositories can also be composed through repository variables. These are variables that can be used in Soul's callterms (e.g. ?var->pred(a) ). 
TODO: we must find a way to unify these variables with normal variables occuring in the rest of the program.


"
Class {
	#name : #LogicRepository,
	#superclass : #Model,
	#instVars : [
		'clauseArray',
		'addressForPredicate',
		'currentAddress',
		'maxAddress',
		'fromLayers',
		'repositoryVariables',
		'exports',
		'storageChanged',
		'name',
		'compilationFactory',
		'tabledRules',
		'callGraph',
		'additionalClauses'
	],
	#category : 'SOUL-Repositories'
}

{ #category : #'signal constants' }
LogicRepository class >> errorSignal [
	
	^SoulRuntimeException
]

{ #category : #initialize }
LogicRepository class >> initialize [
	
	LogicStorage addStorageDependentClass: self
]

{ #category : #'instance creation' }
LogicRepository class >> new [
	"Create an empty logic repository"

	
	^super new initialize
]

{ #category : #'add/del - runtime' }
LogicRepository >> addCallClause: aClause for: aVariable [
	
	| coll |
	"callback from the clause to add a clause with a callterm as conclusion to the repository"

	aClause makeClean.
	aClause definitionRepository: self.
	coll := exports
		at: aVariable name
		ifAbsentPut: [OrderedCollection new].
	coll add: aClause
]

{ #category : #'add/del - runtime' }
LogicRepository >> addClause: aClause [
	"Add a clause to this repository"

	
	aClause addToRepository: self.
	self addClauses: aClause additionalClausesForDefinitionRepository.
	^true
]

{ #category : #'add/del - from storage' }
LogicRepository >> addClauses: aCollection [
	
	aCollection do: [:aClause | self addClause: aClause]	"The following code assumes that all clauses have the same predicate _and_ multiplicity

	| address result multiplicity pred |
	pred := aCollection first predicate.
	multiplicity := aCollection first multiplicity.
	pred
	address := self storeAddressForPredicate: pred.
	aCollection do:[:clause | clause makeClean. clause definitionRepository: self].
	result := self clausesAt: address multiplicity: multiplicity.
	result isEmpty
		ifTrue: [self clausesAt: address multiplicity: multiplicity put: aCollection]
		ifFalse: [self clausesAt: address multiplicity: multiplicity put: result , aCollection]"
]

{ #category : #'add/del - from storage' }
LogicRepository >> addLayers [
	
	| instance program |
	fromLayers
		do:
			[:aLayer | 
			instance := aLayer new.
			aLayer selectors
				do:
					[:sel | 
					program := instance perform: sel.
					self addClauses: program clauses]]
]

{ #category : #'add/del - runtime' }
LogicRepository >> addNormalClause: aClause [
	
	| pred multi address aCollection |
	"callback from the clause to add a normal clause to the repository"

	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self storeAddressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aClause makeClean.
	aClause definitionRepository: self.
	aCollection add: aClause.
	self clausesAt: address multiplicity: multi put: aCollection
]

{ #category : #'add/del - runtime' }
LogicRepository >> addProgram: aProgram [
	
	| clauses |
	"Add a Soul program to the database"

	clauses := aProgram clauses.
	clauses do: [:cl | self addClause: cl]
]

{ #category : #'add/del - from storage' }
LogicRepository >> addTabledRule: aTabledRule [
	
	tabledRules add: aTabledRule
]

{ #category : #'prepare for use' }
LogicRepository >> additionalClausesToBeAdded: aCollection [
	"From an evaluated query..."

	
	additionalClauses := aCollection
]

{ #category : #access }
LogicRepository >> addressForPredicate: predicate [
	"returns the lexical address assigned to a predicate. returns nil if no address was assigned to that predicate"

	
	^addressForPredicate
		at: predicate
		ifAbsent: [nil]
]

{ #category : #private }
LogicRepository >> allClausesAt: anAddress [
	
	| multArray resultClauses clauses |
	"return all clauses at the address"

	multArray := clauseArray at: anAddress.
	resultClauses := OrderedCollection new.
	multArray == nil ifTrue: [^resultClauses].
	(1 to: multArray size)
		do:
			[:index | 
			clauses := multArray at: index.
			clauses == nil ifFalse: [resultClauses addAll: clauses]].
	^resultClauses
]

{ #category : #private }
LogicRepository >> allClausesWith: aMultiplicity [
	"return all clauses with a specific multiplicity"

	
	| resultClauses clauses |
	resultClauses := OrderedCollection new.
	clauseArray
		do:
			[:multArray | 
			multArray == nil
				ifFalse:
					[clauses := multArray at: aMultiplicity.
					clauses == nil ifFalse: [resultClauses addAll: clauses]]].
	^resultClauses
]

{ #category : #'add/del - runtime' }
LogicRepository >> assert: aText [
	
	| program |
	"Add a program in textformat to the repository"

	program := SoulFactory current makeParser
		parse: aText
		onError: [:e :i | self error: 'Not a valid Soul clause'].
	self addProgram: program.
	^true
]

{ #category : #'repository composition' }
LogicRepository >> bind: aVariable with: aRepository [
	
	| varName |
	"Bind a repository variable to a repository"

	varName := aVariable name.
	self bindName: varName with: aRepository
]

{ #category : #'repository composition' }
LogicRepository >> bindName: varName with: aRepository [
	"Bind a repository variable to a repository"

	
	repositoryVariables at: varName put: aRepository.
	exports
		at: varName
		ifAbsent: [^true].
	(exports at: varName) do: [:cl | aRepository importClause: cl]
]

{ #category : #'repository composition' }
LogicRepository >> breakBindingFor: aVariable [
	"Free a repository variable"

	
	^self breakBindingForName: aVariable name
]

{ #category : #'repository composition' }
LogicRepository >> breakBindingForName: varName [
	
	| repository |
	"Free a repository variable"

	repository := repositoryVariables
		at: varName
		ifAbsent: [self error: varName , ' does not exist!'].
	repositoryVariables removeKey: varName.
	exports
		at: varName
		ifAbsent: [^true].
	(exports at: varName) do: [:cl | repository removeClause: cl]
]

{ #category : #private }
LogicRepository >> clausesAt: anAddress multiplicity: aMultiplicity [
	
	| multIndex multArray |
	"return all clauses at the address for the given multiplicity"

	multIndex := aMultiplicity + 2.
	multArray := clauseArray at: anAddress.
	multArray == nil ifTrue: [^OrderedCollection new].
	^multIndex > multArray size
		ifTrue: [OrderedCollection new]
		ifFalse: [multArray at: multIndex]
]

{ #category : #private }
LogicRepository >> clausesAt: anAddress multiplicity: aMultiplicity put: aCollection [
	
	| multIndex multArray |
	"set a collection of clauses at the address for the given multiplicity"

	multIndex := aMultiplicity + 2.
	multArray := clauseArray at: anAddress.
	multArray == nil
		ifTrue:
			[multArray := Array new: 20.
			(1 to: multArray size)
				do:
					[:i | 
					multArray
						at: i
						put: OrderedCollection new].
			clauseArray at: anAddress put: multArray].	"TODO: allow the multiplicity to go over 18"

	^multIndex > multArray size
		ifTrue:
			[self halt:
					'This has not been implemented yet. Try making shorter predicates']
		ifFalse: [multArray at: multIndex put: aCollection]
]

{ #category : #access }
LogicRepository >> clausesDo: aBlock [
	
	| multArray clauses |
	self compile.	"clauseArray do: [ :multArray |
		multArray ifNotNil: [ x do: [ :clauseCollection | 
			clauseCollection ifNotNil: [ clauseCollection do: [ :clause |
				aBlock value: clause
			] ]
		] ]
	]"

	(1 to: currentAddress)
		do:
			[:index | 
			multArray := clauseArray at: index.
			(1 to: multArray size)
				do:
					[:idx | 
					clauses := multArray at: idx.
					clauses do: [:clause | aBlock value: clause]]]
]

{ #category : #private }
LogicRepository >> clear [
	
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	clauseArray := Array new: maxAddress.
	addressForPredicate := Dictionary new.
	currentAddress := 0.	" We should do something with these
	repositoryVariables := Dictionary new."

	exports := Dictionary new.
	self loadNatives
]

{ #category : #access }
LogicRepository >> compilationFactory [
	^compilationFactory
]

{ #category : #access }
LogicRepository >> compilationFactory: aFactory [

	compilationFactory := aFactory
]

{ #category : #'prepare for use' }
LogicRepository >> compile [
	"Compile the clauses in this repository if the changed flag indicates that it is no longer in sync with the storage"
	^self compileForced: additionalClauses isEmpty not
]

{ #category : #'prepare for use' }
LogicRepository >> compileForced: aBoolean [
	"Compile the clauses in this repository if the changed flag indicates that it is no longer in sync with the storage"

	
	| time |
	(aBoolean
		or: [storageChanged or: [(compilationFactory = SoulFactory current) not]])
		ifTrue:
			[time := Time
				millisecondsToRun:
					[self clear.
					self addLayers.
					self addClauses: additionalClauses.	"self createCallGraph."

					self transformTabledRules.
					self createLexicalAddresses.
					storageChanged := false.
					compilationFactory := SoulFactory current].
			Transcript
				show: 'Recompiled repository in ' , time asString , ' ms.';
				cr]
]

{ #category : #private }
LogicRepository >> createCallGraph [
	
	| clauses |
	clauses := OrderedCollection new.
	clauseArray
		do:
			[:multArray | 
			multArray
				ifNotNil:
					[multArray
						do:
							[:clauseCollection | 
							clauseCollection
								ifNotNil: [clauseCollection do: [:clause | clauses add: clause]]]]].
	callGraph := CallGraph withClauses: clauses
]

{ #category : #private }
LogicRepository >> createLexicalAddresses [
	"set lexicaladdresses on all clauses in the repository"

	
	| visitor multArray clauses |
	visitor := LexicalAddressVisitor on: self.
	(1 to: currentAddress)
		do:
			[:index | 
			multArray := clauseArray at: index.
			(1 to: multArray size)
				do:
					[:idx | 
					clauses := multArray at: idx.
					clauses do: [:clause | clause accept: visitor]]]
]

{ #category : #private }
LogicRepository >> expandStorage: aSize [
	
	| newArray |
	"grow the repository"

	maxAddress := maxAddress + aSize.
	newArray := Array new: maxAddress.
	1
		to: currentAddress - 1
		do:
			[:i | 
			newArray
				at: i
				put: (clauseArray at: i)].
	clauseArray := newArray
]

{ #category : #private }
LogicRepository >> importClause: aClause [
	"import a clause to this database, this happens when a repositoryvariable is bound to this repository and the other repository contains callclauses"

	
	| pred aCollection address multi |
	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self storeAddressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aCollection add: aClause.
	self clausesAt: address multiplicity: multi put: aCollection
]

{ #category : #initialize }
LogicRepository >> initialize [
	"Called by the #new class method and initializes all necessary variables"

	
	maxAddress := 500.
	clauseArray := Array new: maxAddress.
	addressForPredicate := Dictionary new.
	currentAddress := 0.
	fromLayers := OrderedCollection new.
	repositoryVariables := Dictionary new.
	exports := Dictionary new.
	self loadNatives.
	storageChanged := false.
	name := 'unnamed repository'.
	tabledRules := OrderedCollection new.
	additionalClauses := OrderedCollection new
]

{ #category : #access }
LogicRepository >> layers [
	"returns the layers that were added to this repository using the #addLayer: method"

	
	^fromLayers
]

{ #category : #'add/del - from storage' }
LogicRepository >> loadLayer: aLayer [
	
	(fromLayers includes: aLayer) ifFalse: [fromLayers add: aLayer].
	Transcript
		show: 'Loading Layer: ' , aLayer asString;
		cr.
	storageChanged := true
]

{ #category : #natives }
LogicRepository >> loadNatives [
	
	| natives |
	"The repository automatically contains a set of native predicates that can be used in Soul programs"

	natives := OrderedCollection new.
	natives
		add:
			(self
				makeNative: 'writeToProlog(?x)'
				if: SoulFactory current makeWriteToPrologClause).
	natives
		add:
			(self
				makeNative: 'getEnv(?var,?idx)'
				if: SoulFactory current makeGetEnvClause).
	natives
		add:
			(self
				makeNative: 'getRepository(?var)'
				if: SoulFactory current makeGetRepositoryClause).
	natives
		add:
			(self
				makeNative: 'setResolver(?block,?args)'
				if: SoulFactory current makeSetResolverClause).
	natives
		add:
			(self
				makeNative: 'not@(?clauses)'
				if: SoulFactory current makeNotClause).
	natives
		add:
			(self
				makeNative: 'or@(?clauses)'
				if: SoulFactory current makeOrClause).
	natives
		add:
			(self
				makeNative: 'and@(?clauses)'
				if: SoulFactory current makeAndClause).
	natives
		add:
			(self
				makeNative: 'envLookup(&term,?termApp)'
				if: SoulFactory current makeEnvLookupClause).
	natives
		add:
			(self
				makeNative: 'clause(&head,&body,?clause)'
				if: SoulFactory current makeClauseClause).
	self addProgram: (ProgramSequence clauses: natives)
]

{ #category : #'repository composition' }
LogicRepository >> lookupBindingFor: aVariable [
	"Lookup the binding for a repository variable"

	
	^self lookupBindingForName: aVariable name
]

{ #category : #'repository composition' }
LogicRepository >> lookupBindingFor: aVariable ifAbsent: aBlock [
	"Lookup the binding for a repository variable"

	
	^self
		lookupBindingForName: aVariable name
		ifAbsent: aBlock
]

{ #category : #'repository composition' }
LogicRepository >> lookupBindingForName: varName [
	"Lookup the binding for a repository variable"

	
	^self
		lookupBindingForName: varName
		ifAbsent: [self error: varName , ' does not exist!']
]

{ #category : #'repository composition' }
LogicRepository >> lookupBindingForName: varName ifAbsent: aBlock [
	"Lookup the binding for a repository variable"

	
	^repositoryVariables at: varName ifAbsent: aBlock
]

{ #category : #private }
LogicRepository >> makeNative: aString if: aClauseClass [
	
	| conclusion resultClause temp |
	"Production of native clauses"

	conclusion := (SoulFactory current makeParser
		parse: aString
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString])
		clauses first conclusion.
	temp := OrderedCollection new.
	temp add: (aClauseClass newWith: conclusion termSequence).
	resultClause := SoulFactory current makeRule
		condition:
			(SoulFactory current makeTermSequence terms: temp containsCut: false)
		conclusion: conclusion.
	^resultClause
]

{ #category : #access }
LogicRepository >> name [
	
	^name
]

{ #category : #access }
LogicRepository >> name: aName [
	
	name := aName
]

{ #category : #private }
LogicRepository >> nextAddress [
	"returns the next free address in the repository"

	
	currentAddress := currentAddress + 1.
	currentAddress > maxAddress ifTrue: [self expandStorage: 500].
	^currentAddress
]

{ #category : #access }
LogicRepository >> normalAddressLookup: anAddress multiplicity: aNumber [
	"Do a lookup of a normal predicate using the address of the predicate and the required multiplicity. This method returns both the clauses whose conclusion matches the 	predicate / multiplicity exactly, as well as the 'variable multiplicity' predicates in the repository"

	
	^(self clausesAt: anAddress multiplicity: aNumber)
		, (self clausesAt: anAddress multiplicity: -1)
]

{ #category : #natives }
LogicRepository >> reLoadNatives [
	
	self retractNatives.
	self loadNatives
]

{ #category : #'add/del - runtime' }
LogicRepository >> removeClause: aClause [
	
	self removeClause: aClause cleanupGenerated: false
]

{ #category : #'add/del - runtime' }
LogicRepository >> removeClause: aClause cleanupGenerated: aBoolean [
	
	| pred multi address aCollection |
	"remove a clause from the database, the argument must be the same clause object as the one in the repository"

	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self addressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aCollection
		remove: aClause
		ifAbsent: [self error: 'unknown error, tabled rules probably'].
	aBoolean
		ifTrue: [aClause isTabledRule ifTrue: [self removeTabledRule: aClause]]
]

{ #category : #private }
LogicRepository >> removeGeneratedRules [
	
	tabledRules
		do:
			[:aTabledRule | 
			| generated |
			generated := aTabledRule generatedRules.
			generated do: [:aRule | self removeClause: aRule].	"not sure if they are re-used or re-generated, so clearing to be safe"

			aTabledRule generatedRules: OrderedCollection new].
	tabledRules := OrderedCollection new
]

{ #category : #'add/del - from storage' }
LogicRepository >> removeLayer: aClass [
	"Remove the layer from this repository"

	
	fromLayers remove: aClass.
	storageChanged := true
]

{ #category : #private }
LogicRepository >> removeTabledRule: aTabledRule [
	
	aTabledRule generatedRules
		do: [:generated | self removeClause: generated cleanupGenerated: true].
	tabledRules
		remove: aTabledRule
		ifAbsent: [^self halt]
]

{ #category : #private }
LogicRepository >> repositoryBindings [
	
	^repositoryVariables
]

{ #category : #'add/del - runtime' }
LogicRepository >> retract: aPredicateKey [
	
	| pred multi |
	"Retract all clauses with a particular predicatekey = predicate / multiplicity"

	pred := LogicStorage predicateOfKey: aPredicateKey.
	multi := LogicStorage multiplicityOfKey: aPredicateKey.
	^self retract: pred multiplicity: multi
]

{ #category : #'add/del - runtime' }
LogicRepository >> retract: aPredicate multiplicity: multi [
	
	| address clauses |
	"Retract all clauses with a particular predicate and multiplicity"

	address := self addressForPredicate: aPredicate.
	clauses := self clausesAt: address multiplicity: multi.
	clauses isEmpty
		ifFalse:
			[self
				clausesAt: address
				multiplicity: multi
				put: (clauses allButFirst: 1)].
	^true
]

{ #category : #'add/del - runtime' }
LogicRepository >> retractAll: aPredicateKey [
	
	| pred multi |
	"Retract all clauses with a particular predicatekey = predicate / multiplicity"

	pred := LogicStorage predicateOfKey: aPredicateKey.
	multi := LogicStorage multiplicityOfKey: aPredicateKey.
	^self retractAll: pred multiplicity: multi
]

{ #category : #'add/del - runtime' }
LogicRepository >> retractAll: aPredicate multiplicity: multi [
	
	| address |
	"Retract all clauses with a particular predicate and multiplicity"

	address := self addressForPredicate: aPredicate.
	self
		clausesAt: address
		multiplicity: multi
		put: OrderedCollection new.
	^true
]

{ #category : #natives }
LogicRepository >> retractNatives [
	
	self
		clausesDo:
			[:clause | 
			| conditions |
			clause notNil
				ifTrue:
					["I encountered nil-clauses, this does not seem correct."

					conditions := clause condition terms.
					(conditions size >= 1 and: [conditions first isKindOf: NativeClause])
						ifTrue: [self removeClause: clause]]]
]

{ #category : #private }
LogicRepository >> storeAddressForPredicate: predicate [
	"sets and returns the address for this predicate"

	
	^addressForPredicate
		at: predicate
		ifAbsentPut: [self nextAddress]
]

{ #category : #access }
LogicRepository >> tabledRules [
	
	^tabledRules
]

{ #category : #'prepare for use' }
LogicRepository >> transformTabledRules [
	
	| newRules |
	"we generate the new rules"

	newRules := TabledRule transformTabledRules: tabledRules withCallGraph:
			callGraph.	"we remove the old tabled rules as they are not needed in the resolution. All the transformed rules are in newRules"

	tabledRules
		do:
			[:aTabledRule | self removeClause: aTabledRule cleanupGenerated: false].	"we add the newly generated rules to the repo"

	newRules do: [:aRule | self addClause: aRule].	"should probably be in seperate method"

	SLGCall initializeQueries
]

{ #category : #'update mechanism' }
LogicRepository >> update: anAspect with: aLayerClass [
	"set the flag that this repository is no longer up-to-date"

	"check if the loaded layers have not been expanded with sublayers"

	
	anAspect == #addLayer
		ifTrue:
			[(fromLayers includes: aLayerClass superclass)
				ifTrue:
					[self loadLayer: aLayerClass.
					storageChanged := true]].
	anAspect == #removeLayer
		ifTrue:
			[(fromLayers includes: aLayerClass)
				ifTrue:
					[self removeLayer: aLayerClass.
					storageChanged := true]].
	anAspect == #changePredicate & (fromLayers includes: aLayerClass)
		ifTrue: [storageChanged := true].
	anAspect == #factoryChanged
		ifTrue: [storageChanged := (compilationFactory = SoulFactory current) not]
]

{ #category : #access }
LogicRepository >> varArgsAddressLookup: anAddress [
	"Do a lookup of a 'variable multiplicity' predicate using the address of the predicate. This method returns all clauses whose conclusion matches the predicate"

	
	^self allClausesAt: anAddress
]

{ #category : #'repository composition' }
LogicRepository >> variables [
	
	| visitor |
	visitor := RepositoryVariableAccVisitor new.
	self compile.
	1
		to: currentAddress
		do:
			[:index | 
			(clauseArray at: index)
				do:
					[:cl | cl == nil ifFalse: [cl do: [:clause | clause accept: visitor]]]].
	^visitor variables
]
