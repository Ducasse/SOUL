Class {
	#name : #TotalTimer,
	#superclass : #LogicTestNotifier,
	#instVars : [
		'totalsForClasses',
		'caseCount'
	],
	#category : 'SOUL-Tests'
}

{ #category : #Private }
TotalTimer >> addToCurrentCaseCount: number [
	
	caseCount = 0
		ifTrue: [caseCount := number]
		ifFalse: [caseCount := caseCount + number]
]

{ #category : #'Test Interface' }
TotalTimer >> afterCaseDo: aTestCase [
	"a testcase was run. As a result, the queries contained in the testcasewere run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount remembered the sum of all the timings of these queries. Remember the result here."

	
	self
		keepTime: self caseCount
		forClass: aTestCase class.
	self
		output: aTestCase selector printString
		took: self caseCount
]

{ #category : #'Test Interface' }
TotalTimer >> afterQuery: results description: descriptionString [
	"A query was run, and the results are in 'results'. Output the description and the time it took. Remember the time it took for the current case (the total for the case will be the sum for all its individual queries)"

	
	| took |
	took := results timeTaken.
	self addToCurrentCaseCount: took.
	self output: descriptionString took: took
]

{ #category : #'Test Interface' }
TotalTimer >> beforeCaseDo: aTestCase [
	"a testcase will be run. As a result, the queries contained in the testcase will be run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount will remember the sum of all the timings of these queries. This total is reset here."

	
	self resetCaseCount
]

{ #category : #Private }
TotalTimer >> caseCount [
	"Return the caseCount"

	
	^caseCount
]

{ #category : #Private }
TotalTimer >> keepTime: took forClass: aClass [
	"Something was tested in aClass that took a certain time. Keep the total execution time for that class in the dictionary."

	
	| key currentTotalTime |
	key := aClass name.
	currentTotalTime := self totalsForClasses
		at: key
		ifAbsent: [0].
	self totalsForClasses
		at: key
		put: currentTotalTime + took
]

{ #category : #Private }
TotalTimer >> output: aString took: number [
	"Output the given string and the number (indicating the time it took for the result to obtain)"

	
	(self outputStream)
		nextPutAll: aString;
		tab;
		nextPutAll: 'took: ';
		tab;
		print: number;
		cr
]

{ #category : #Public }
TotalTimer >> outputClassResults [
	
	| sortedAssociations |
	sortedAssociations := self totalsForClasses associations
		asSortedCollection: [:assoc1 :assoc2 | assoc2 < assoc2].
	sortedAssociations
		do:
			[:assoc | 
			self
				output: assoc key
				took: assoc value]
]

{ #category : #Public }
TotalTimer >> outputTotalResult [
	
	self
		output: 'Total'
		took: self totalResult
]

{ #category : #Public }
TotalTimer >> ranQuery: results description: descriptionString [
	"A query was run, with as description the given string. The results are in 'results'."

	
	self subclassResponsibility
]

{ #category : #Private }
TotalTimer >> resetCaseCount [
	"Reset the counter to hold the total for a single case"

	
	caseCount := 0
]

{ #category : #Private }
TotalTimer >> resetTimings [
	"reset the information regarding the classes (cannot do this automatically; since testsuites are just collections of individual testCases. Hence I don't know when the testing starts and ends)."

	
	totalsForClasses := nil
]

{ #category : #Public }
TotalTimer >> runCase: aTestCase do: aBlock [
	"a testcase is being run. Keep the result for the testCase's class"

	"a testcase is being run. Run the supplied block. As a result, the queries contained in the testcase will be run, and their totals collected in #ranQuery:description:. As a side-effect, the instance variable caseCount will remember the sum of all the timings of these queries. This is the time this case took to execute. As an alternative, we could also simply time the block, which would time the execution of the whole block, including writing the results, etc. While this is more general, the implementation only includes the time for executing without other overhead."

	
	self resetCaseCount.
	aBlock value.
	self
		keepTime: self caseCount
		forClass: aTestCase class
]

{ #category : #Public }
TotalTimer >> totalResult [
	
	^self totalsForClasses values
		inject: 0
		into: [:subTotal :number | subTotal + number]
]

{ #category : #Private }
TotalTimer >> totalsForClasses [
	
	totalsForClasses isNil ifTrue: [totalsForClasses := Dictionary new].
	^totalsForClasses
]
