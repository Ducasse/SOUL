Class {
	#name : #Results,
	#superclass : #Object,
	#instVars : [
		'results',
		'query',
		'timeTaken',
		'success'
	],
	#category : 'SOUL-EvalPrintLoop'
}

{ #category : #'signal constants' }
Results class >> errorSignal [
	
	^SoulError
]

{ #category : #'instance creation' }
Results class >> new [
	
	^super new initialize
]

{ #category : #'instance creation' }
Results class >> onQuery: aQuery [
	
	^self new query: aQuery
]

{ #category : #'private-access' }
Results >> add: aCollectionOfBindings [
	
	| coll |
	aCollectionOfBindings ~~ false
		ifTrue:
			[self success: true.
			aCollectionOfBindings
				do:
					[:aBinding | 
					| var |
					var := aBinding variable.
					var isHiddenVariable
						ifFalse:
							[coll := results
								at: var
								ifAbsentPut: [OrderedCollection new].
							coll add: aBinding value]]].
	self changed: #add:
]

{ #category : #printing }
Results >> basicResultText [
	
	| stream |
	stream := WriteStream on: String new.
	self printBasicInformationOn: stream.
	^stream contents
]

{ #category : #printing }
Results >> displayString [
	
	^self basicResultText
]

{ #category : #'public-enumerating' }
Results >> do: aBlock [
	"Enumerate over the results. aBlock is a smalltalkblock that must have 1  
	parameter, which will be bound to a Collection of Binding, for  
	each subsequent result"

	
	1
		to: self size
		do:
			[:index | 
			| collect |
			collect := OrderedCollection new.
			results
				keysAndValuesDo:
					[:key :value | 
					collect
						add:
							(Binding
								var: key
								value: (value at: index))].
			aBlock value: collect]
]

{ #category : #'public-enumerating' }
Results >> do: aBlock forVariableNames: aCollectionOfVariableNames [
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have as many  
	parameters as the number of variables. The parameters will be bound  
	to a their value, for each subsequent result"

	
	self
		do: aBlock
		forVariables:
			(aCollectionOfVariableNames
				collect:
					[:each | 
					| temp |
					results keys do: [:key | key name = each ifTrue: [temp := key]].
					temp])
]

{ #category : #'public-enumerating' }
Results >> do: aBlock forVariables: aCollectionOfVariables [
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have as many  
	parameters as the number of variables. The parameters will be bound  
	to a their value, for each subsequent result"

	
	1
		to: self size
		do:
			[:index | 
			aBlock
				valueWithArguments:
					(aCollectionOfVariables collect: [:var | (results at: var) at: index])
						asArray]
]

{ #category : #'public-enumerating' }
Results >> doCollection: aBlock forVariableNames: aCollectionOfVariableNames [
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have 1 parameter, which will be bound to a collection of values for the variables named"

	
	self
		doCollection: aBlock
		forVariables:
			(aCollectionOfVariableNames
				collect:
					[:each | 
					| temp |
					results keys do: [:key | key name = each ifTrue: [temp := key]].
					temp])
]

{ #category : #'public-enumerating' }
Results >> doCollection: aBlock forVariables: aCollectionOfVariables [
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have 1 paramater. The parameter will be bound  
	to a collection of values for the variables"

	
	1
		to: self size
		do:
			[:index | 
			aBlock
				value:
					(aCollectionOfVariables collect: [:var | (results at: var) at: index])
						asArray]
]

{ #category : #'public-access' }
Results >> downedResultsForVariableNamed: aString [
	
	^(self resultsForVariableNamed: aString)
		collect:
			[:each | 
			each
				soulDownIn: Environment new
				startAt: 0]
]

{ #category : #'public-access' }
Results >> fails [
	"Did the query fail?"

	
	^success not
]

{ #category : #initialize }
Results >> initialize [
	
	results := Dictionary new.
	self success: false.
	timeTaken := 0
]

{ #category : #'public-access' }
Results >> isEmpty [
	"Is the set of results empty?"

	
	^results isEmpty
]

{ #category : #printing }
Results >> printBasicInformationOn: aStream [
	
	results isEmpty
		ifTrue:
			[aStream write: '['.
			self success printOn: aStream.
			aStream write: ']']
		ifFalse:
			[| keys values |
			keys := OrderedCollection new.
			values := OrderedCollection new.
			results
				keysAndValuesDo:
					[:key :value | 
					keys add: key.
					values add: value].
			1
				to: self size
				do:
					[:resultIndex | 
					| keyIndex |
					aStream write: '['.
					keyIndex := 1.
					keys
						do:
							[:key | 
							(Binding
								var: key
								value: ((values at: keyIndex) at: resultIndex)) printOn: aStream.
							keyIndex := keyIndex + 1]
						separatedBy:
							[aStream
								write: ',';
								cr].
					aStream
						write: ']';
						cr;
						cr]]
]

{ #category : #printing }
Results >> printOn: aStream [
	
	aStream
		write: 'SOUL found';
		cr;
		write:
				self size asString , ' solutions in ' , timeTaken asString , ' ms for:';
		cr.
	query printOn: aStream.
	aStream
		cr;
		cr;
		cr.
	self printBasicInformationOn: aStream
]

{ #category : #'public-access' }
Results >> query [
	"Returns the query that was used to obtain these results"

	
	^query
]

{ #category : #initialize }
Results >> query: aQuery [
	
	query := aQuery
]

{ #category : #'private-access' }
Results >> results [
	"Implemented by Tom Mens on 2002-02-13"

	
	^results
]

{ #category : #'public-access' }
Results >> resultsForVariableNamed: aString [
	
	^self success
		ifTrue: [self results at: (self variableNamed: aString)]
		ifFalse: [#()]
]

{ #category : #'public-access' }
Results >> size [
	"Returns the number of results"

	
	^results isEmpty
		ifTrue: [0]
		ifFalse: [results associations first value size]
]

{ #category : #'public-access' }
Results >> success [
	"Is the query succesfull?"

	
	^success
]

{ #category : #'private-access' }
Results >> success: aBoolean [
	
	success := aBoolean
]

{ #category : #'public-access' }
Results >> timeTaken [
	"Returns the time in milliseconds that was required to obtain these 
	results "

	
	^timeTaken
]

{ #category : #'private-access' }
Results >> timeTaken: aTime [
	
	timeTaken := aTime
]

{ #category : #'public-access' }
Results >> variableNamed: aString [
	
	^self variables
		detect: [:keyVar | keyVar name = aString]
		ifNone:
			[self
				error:
					'Variable ''?' , aString , ''' not found in query: '''
						, self query printString , '''']
]

{ #category : #'public-access' }
Results >> variables [
	"returns the variables that these results are about. Return the keys in the results dictionary, since they contain the actual variables used. This method used to return the variables used by the query, but these are other variables. "

	
	^self results keys
]
