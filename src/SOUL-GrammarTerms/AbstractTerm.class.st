"
The superclass of all parsetree elements that represent SOUL logic terms.
"
Class {
	#name : #AbstractTerm,
	#superclass : #Object,
	#instVars : [
		'definitionRepository'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'signal constants' }
AbstractTerm class >> errorSignal [
	
	^SoulError
]

{ #category : #'open unification pragmas' }
AbstractTerm class >> openUnificationMethodPragmas [
	
	<pragmas: #instance>
	^#(#unificationmethod:)
]

{ #category : #visitor }
AbstractTerm >> accept: aVisitor [
	"Every term can be visited by a visitor and should implement this part of the design pattern

	Note that the accept method must return the value of the visit message."

	
	^self subclassResponsibility
]

{ #category : #access }
AbstractTerm >> additionalClausesForDefinitionRepository [
	
	^nil
]

{ #category : #fuzzy }
AbstractTerm >> annotation [
	 
	^SoulFactory current defaultAnnotation
]

{ #category : #converting }
AbstractTerm >> asCompilationString [
	
	| tempStream |
	tempStream := WriteStream on: String new.
	self printForCompileOn: tempStream.
	^tempStream contents
]

{ #category : #converting }
AbstractTerm >> asDCGConclusionWithSize: aSize [
	
	self error: 'This term cannot be used as a head in a DCG rule'
]

{ #category : #converting }
AbstractTerm >> asDCGConditionFor: counter [
	
	self error: 'This term cannot be used as a production in a DCG rule'
]

{ #category : #converting }
AbstractTerm >> asPredicateName [
	" send by repository when clauses are added to it. At that time, no runtime environment is available"

	
	^self asPredicateNameInEnv: nil startAt: nil
]

{ #category : #converting }
AbstractTerm >> asPredicateNameInEnv: anEnv startAt: anIndex [
	"When this terms is used as a predicate (functor), generate its representation as a predicatename. The default behaviour generates an error"

	
	self error: 'The term ' , self asString , ' cannot be used as a predicate'
]

{ #category : #printing }
AbstractTerm >> asPrettyString [
	
	| aStream |
	aStream := TextStream on: String new.
	self prettyPrintOn: aStream scope: #asClause.
	^aStream contents
]

{ #category : #converting }
AbstractTerm >> asProlog [
	
	^self asPrologIn: nil startAt: nil
]

{ #category : #converting }
AbstractTerm >> asPrologIn: env startAt: idx [
	
	| stream |
	stream := WriteStream on: String new.
	self printAsPrologOn: stream scope: #asClause in: env startAt: env.
	^stream contents
]

{ #category : #quotedCode }
AbstractTerm >> asSourceStringIn: anEnv startAt: anIndex [
	"This method is used by the downing process for the QuotedCode. Basically, the parser generates a list of constants and variables when parsing the text inside the QuotedCode. When the quotedcode is downed, it needs to be converted to a string. This is where this method gets invoked"

	
	self halt.
	^self asString
]

{ #category : #scoping }
AbstractTerm >> definitionRepository [
	"Each term keeps a pointer to the repository where it was defined. This method is used by the resolution process to determine the term's static scoped repository"

	
	^definitionRepository
]

{ #category : #scoping }
AbstractTerm >> definitionRepository: aRepository [
	"Each term keeps a pointer to the repository where it was defined"

	
	definitionRepository := aRepository
]

{ #category : #reification }
AbstractTerm >> explicitSoulUp [
	"This message is used to explicitly wrap a Soul term anyhow. It is normally called within a smalltalkterm in a logic program. For special purposes only, to be used with caution"

	
	^super soulUp
]

{ #category : #fuzzy }
AbstractTerm >> innerTerm [
	
	^self
]

{ #category : #testing }
AbstractTerm >> isAnnotatedTerm [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isCallTerm [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isCompoundTerm [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isConstantFunctor [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isCut [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isHiddenVariable [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isIndexable [
	
	^true
]

{ #category : #testing }
AbstractTerm >> isKeywordFunctor [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isMessageFunctor [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isNative [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentTo: aTerm [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToCompoundTerm: aCompoundTerm [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToEmptyList: anEmptyListConstant [
	
	^false
]

{ #category : #resolving }
AbstractTerm >> isSLGEquivalentToSmalltalkTerm: aTerm [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToSymbiosisTerm: aSymbiosisTerm [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToTermSequence: aTermSequence [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToUppedObject: anUppedObject [
	
	^false
]

{ #category : #slgtesting }
AbstractTerm >> isSLGEquivalentToVariable: aVariable [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isUnaryMessageFunctor [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isUppedObject [
	
	^false
]

{ #category : #testing }
AbstractTerm >> isVariable [
	
	^false
]

{ #category : #access }
AbstractTerm >> multiplicity [
	
	^0
]

{ #category : #access }
AbstractTerm >> predicate [
	"For storing this kind of term in the logic database, this method creates a unique key to identify this term when the resolution process needs to retrieve it 	from the logic database. The default behaviour is generates an error."

	
	^self
		error:
			'Cannot store a term with as conclusion a ' , self class asString ,
					' in the logic repository'
]

{ #category : #resolving }
AbstractTerm >> predicateInEnv: anEnv startAt: anIndex [
	"This method is called at runtime if the lexicalAddress for this clause was not filled in. This can either be because this clause was not present when the database was 	compiled, e.g. if a variable was used as functor"

	
	^self subclassResponsibility
]

{ #category : #printing }
AbstractTerm >> prettyPrintAsFunctorOn: aStream scope: id [
	"This method should print the textual representation of the term when it  
	is used as a functor. This is necessary if uppedobjects are used as  
	functors"

	
	self prettyPrintOn: aStream scope: id
]

{ #category : #printing }
AbstractTerm >> prettyPrintAsKeywordArgOn: aStream scope: id [
	
	^self prettyPrintOn: aStream scope: id
]

{ #category : #printing }
AbstractTerm >> prettyPrintAsKeywordOn: aStream scope: id [
	"This method should print the textual representation of the term when it  
	is used as a keyword. This is necessary if uppedobjects are used as  
	keyword"

	
	self prettyPrintOn: aStream scope: id
]

{ #category : #printing }
AbstractTerm >> prettyPrintOn: aStream scope: id [
	"pretty printing"

	
	self printOn: aStream
]

{ #category : #printing }
AbstractTerm >> printAsFunctorOn: aStream [
	"This method should print the textual representation of the term when it  
	is used as a functor. This is necessary if uppedobjects are used as  
	functors"

	
	self printOn: aStream
]

{ #category : #printing }
AbstractTerm >> printAsKeywordArgOn: aStream [
	
	^self printOn: aStream
]

{ #category : #printing }
AbstractTerm >> printAsPrologFunctorOn: aStream scope: id in: env startAt: idx [
	"This method should print the textual representation of the term when it  
	is used as a functor. This is necessary if uppedobjects are used as  
	functors"

	
	self printAsPrologOn: aStream scope: id in: env startAt: idx
]

{ #category : #printing }
AbstractTerm >> printAsPrologOn: aStream scope: anObject in: env startAt: idx [
	
	aStream write:
			'error("Translation not yet implemented, please contact KrisG.")'	"self subclassResponsibility"
]

{ #category : #printing }
AbstractTerm >> printForCompileOn: aStream [
	"This method should print a representation of the term which is  
	SmallTalk code that constructs the term"

	
	^self subclassResponsibility
]

{ #category : #printing }
AbstractTerm >> printOn: aStream [
	"This method should print the textual representation of the term"

	
	^self subclassResponsibility
]

{ #category : #private }
AbstractTerm >> printOrderedCollectionForCompile: collection on: aStream [
	
	aStream write: 'OrderedCollection new'.
	collection
		do:
			[:element | 
			aStream write: 'add:('.
			element printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself'
]

{ #category : #quotedCode }
AbstractTerm >> quotedCodeToList [
	" To extract the list representation of a quotedcode. This method gets called to all elements in a quotedcode before they are put inside the list representation. All normal terms inside the quotedcode should simply return themselves"

	
	^self
]

{ #category : #scoping }
AbstractTerm >> recursiveDefinitionRepository: aRepository [
	"Each term keeps a pointer to the repository where it was defined. This method is used by the repository when a clause (and all its subterms) get added to it"

	
	self definitionRepository: aRepository
]

{ #category : #resolving }
AbstractTerm >> resolveIn: anEnv startAt: anIndex [
	"This method gets invoked by the kernel to start a resolution process with this term as a goal"

	
	self error: 'Cannot resolve a ' , self class asString
]

{ #category : #converting }
AbstractTerm >> smalltalkBlockString [
	"This method is used by the building process for the SmalltalkTerms. Basically, the parser generates a list of constants and variables when parsing the 	code inside the SmalltalkTerm. When the code is handed to the Smalltalk Compiler, the code needs to be printed out again. This is where this method 	gets invoked"

	
	^self asString
]

{ #category : #reification }
AbstractTerm >> soulDownIn: anEnv startAt: anIndex [
	"downing a SOUL term to the SmallTalk Environment means returning the SOUL term itself"

	
	^self
]

{ #category : #reification }
AbstractTerm >> soulUp [
	"upping a SOUL term to the SOUL Environment means returning  the SOUL term itself"

	
	^self
]

{ #category : #fuzzy }
AbstractTerm >> term [
	
	^self
]

{ #category : #reification }
AbstractTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	"This method should be implemented by the subclasses and return a fully ground term representation for this term by walking the environment when 	necessary and constructing a new term for the representation as a result"

	
	^self subclassResponsibility
]

{ #category : #'code tagging' }
AbstractTerm >> ugly: message [
	"Used to tag code with annotations about how ugly it is. Implemented here because it is used in the keyworded syntax extension but does not actually seem to exist (When I developed the keyworded syntax I could use that message but it does not seem to be part of the base visualworks packages, I'm guessing it came from the StarBrowser or something"
	
	
]

{ #category : #unification }
AbstractTerm >> unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"double dispatch the unification of the term"

	
	^self subclassResponsibility
]

{ #category : #unification }
AbstractTerm >> unifyWithAnnotatedTerm: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"Simply ignore the annotation part.
	Otherwise, crisp goals will not resolve against annotated rules."

	"^self
		unifyWith: aTerm transitiveTerm
		inEnv: anEnv
		myIndex: sourceIndex
		hisIndex: targetIndex
		inSource: inSource"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a compound, standard behaviour is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithCut: aCut inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithDelayedVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"standard behaviour of unification with a delayedvariable is the same as with a normal variable"

	
	^self unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource
]

{ #category : #unification }
AbstractTerm >> unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self unifyWithUppedObject: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource
]

{ #category : #unification }
AbstractTerm >> unifyWithKeywordFunctor: term inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self unifyWithCompoundTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource
]

{ #category : #unification }
AbstractTerm >> unifyWithMessageFunctor: term inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithNativeClause: aNative inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithNegVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a positive variable, standard is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithPosVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a positive variable, standard is as with a normal variable"

	
	^self unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource
]

{ #category : #unification }
AbstractTerm >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a quotedCodeTerm, standard is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithResultMessageTerm: aRM inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithSmalltalkTerm: aSTTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a smalltalkterm, standard is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithTemplateQueryTerm: aTQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a typedquotedCodeTerm, standard is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithTermSequence: term inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithUnaryMessageFunctor: unaryFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self = unaryFunctor message
]

{ #category : #unification }
AbstractTerm >> unifyWithUnderscoreVariable: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"everything unifies with an underscore variable"

	
	^true
]

{ #category : #unification }
AbstractTerm >> unifyWithUppedASTObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with an object, standard is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a varargscompound, standard behaviour is false"

	
	^false
]

{ #category : #unification }
AbstractTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	"unify this term with a variable, standard is false"

	
	^false
]

{ #category : #access }
AbstractTerm >> usesPredicate: aPredicate multiplicity: aNumber [
	"This method is used by repositories to look up all predicated used inside a clause. Standard behaviour returns false"

	
	^false
]
