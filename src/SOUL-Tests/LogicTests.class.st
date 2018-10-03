Class {
	#name : #LogicTests,
	#superclass : #TestCase,
	#instVars : [
		'currentTotal'
	],
	#classVars : [
		'IsDetailedTimed',
		'IsSelectorTimed',
		'LogicTimer'
	],
	#category : 'SOUL-Tests'
}

{ #category : #Examples }
LogicTests class >> averageTotalOfRuns: number [
	"Run me a certain times, and return the average time it took"

	"QSOULArithmeticTest averageTotalOfRuns: 3"

	
	| allTotals theTimer suite |
	allTotals := OrderedCollection new.
	theTimer := TotalTimer new.
	self setLogicTimer: theTimer.
	suite := self buildSuite.
	number
		timesRepeat:
			[suite run.
			allTotals add: theTimer totalResult.
			theTimer resetTimings].
	^(allTotals
		inject: 0
		into: [:subTotal :timing | subTotal + timing]) / number
]

{ #category : #'Logic Timer' }
LogicTests class >> defaultLogicTimer [
	"returns the default notifier, that does no timing."

	
	^LogicTestNotifier new
]

{ #category : #Examples }
LogicTests class >> fullyTimeSuite [
	"Fully time me, and output the results on the default stream."

	
	| theTimer |
	theTimer := TotalTimer new.
	self setLogicTimer: theTimer.
	self buildSuite run.
	theTimer outputClassResults.
	theTimer outputTotalResult
]

{ #category : #Examples }
LogicTests class >> fullyTimeSuiteOnFileNamed: aFileNameString [
	"Fully time me, and output the results on a file with the given name."

	
	| stream |
	stream := aFileNameString asFilename writeStream.
	[self fullyTimeSuiteOnStream: stream] ensure: [stream close]
]

{ #category : #Examples }
LogicTests class >> fullyTimeSuiteOnStream: aStream [
	"Fully time me, and output the results on the given stream."

	
	| theTimer |
	theTimer := TotalTimer new.
	theTimer outputStream: aStream.
	self setLogicTimer: theTimer.
	self buildSuite run.
	theTimer outputClassResults.
	theTimer outputTotalResult
]

{ #category : #Examples }
LogicTests class >> fullyTimeSuitePromptForFile [
	"for one class: QSOULArithmeticTest fullyTimeSuitePromptForFile"

	"For all: QSOULLogicTests fullyTimeSuitePromptForFile"

	"Prompt for a file name, fully time me, and output the results on a file with the given name."

	
	| fileName |
	fileName := Dialog
		requestFileName: 'Give the name of the file to write the results on:'
		default: 'testTimings.tsf'
		version: #new
		ifFail:
			[^Dialog warn:
					'Not testing anything since there is no file to save the results.'].
	self fullyTimeSuiteOnFileNamed: fileName
]

{ #category : #'Logic Timer' }
LogicTests class >> initializeLogicTimer [
	"initializes the logic timer."

	
	self setLogicTimer: self defaultLogicTimer
]

{ #category : #Testing }
LogicTests class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	"Overridden because that is the case here."

	
	^self name = #LogicTests
]

{ #category : #configuration }
LogicTests class >> isDetailedTimed [
	"this setting determines whether individual tests are timed, and the  
	results displayed on the Transcript. By default this is false (so  
	it runs as plain tests, without timing). Set this to true to allow fine  
	grained benchmarking."

	
	IsDetailedTimed isNil ifTrue: [IsDetailedTimed := true].
	^IsDetailedTimed
]

{ #category : #configuration }
LogicTests class >> isSelectorTimed [
	"this setting determines whether the user specific timings are executed 
	and  
	shown (see the methods #startWatch and #stopAndShowWatch). If true,  
	these results are displayed on the Transcript. By default this is false (so 
	it runs as plain tests, without timing). Set this true to allow course  
	grained benchmarking."

	
	IsSelectorTimed isNil ifTrue: [IsSelectorTimed := false].
	^IsSelectorTimed
]

{ #category : #'Logic Timer' }
LogicTests class >> logicTimer [
	"Return the current tmer being used."

	
	LogicTimer isNil ifTrue: [self initializeLogicTimer].
	^LogicTimer
]

{ #category : #configuration }
LogicTests class >> setDetailedTimed [
	"self setDetailedTimed"

	"this setting determines that every individual tests is timed, and that  
	these results are displayed on the Transcript"

	
	IsDetailedTimed := true
]

{ #category : #'Logic Timer' }
LogicTests class >> setLogicTimer: aLogicTimer [
	"Sets the logic timer to the argument."

	
	LogicTimer := aLogicTimer
]

{ #category : #configuration }
LogicTests class >> setNotDetailedTimed [
	"self setNotDetailedTimed"

	"this setting determines that detailed timings are not displayed"

	
	IsDetailedTimed := false
]

{ #category : #configuration }
LogicTests class >> setNotSelectorTimed [
	"self setNotSelectorTimed"

	"this setting determines that no timings per selector are shown"

	
	IsSelectorTimed := false
]

{ #category : #configuration }
LogicTests class >> setSelectorTimed [
	"self setSelectorTimed"

	"show timings per test selector executed"

	
	IsSelectorTimed := true
]

{ #category : #Private }
LogicTests >> currentTotal [
	
	currentTotal isNil ifTrue: [currentTotal := 0].
	^currentTotal
]

{ #category : #Accessing }
LogicTests >> logicTimer [
	
	^self class logicTimer
]

{ #category : #Assertions }
LogicTests >> processQuery: aString description: descriptionString [
	"This method is exactly the same as processQuery:resultsCheck:description: 
	except that the resultcheck is left out. It is replaced by a default check 
	that the result was successful."

	
	self
		processQuery: aString
		resultsCheck: [:results | results success]
		description: descriptionString
]

{ #category : #Assertions }
LogicTests >> processQuery: aString description: descriptionString repository: aRepository [
	"This method is exactly the same as processQuery:resultsCheck:description: 
	except that the resultcheck is left out. It is replaced by a default check 
	that the result was successful."

	
	self
		processQuery: aString
		resultsCheck: [:results | results success]
		description: descriptionString
		repository: aRepository
]

{ #category : #Assertions }
LogicTests >> processQuery: aString resultsCheck: checkBlock description: descriptionString [
	
	self
		processQuery: aString
		resultsCheck: checkBlock
		description: descriptionString
		repository: self repository
]

{ #category : #Assertions }
LogicTests >> processQuery: anId resultsCheck: checkBlock description: descriptionString repository: aRepository [
	"Note that the description is not used here, but is meant for subclasses  
	that allow to log extra information (for example to show the time it took 
	to process a query)."

	
	| results |
	"aString := self queryWithId: anId.
	self logicTimer beforeQuery: aString."
	results := (SoulFactory current evaluatorForLogicQuery eval: anId in:
			aRepository) allResults.
	self assert: (checkBlock value: results)	"self logicTimer afterQuery: results description: descriptionString"
]

{ #category : #Accessing }
LogicTests >> repository [
	
	^SoulFactory testRepository
]

{ #category : #Private }
LogicTests >> resetTotal [
	"set the current total to 0"

	
	currentTotal := 0
]

{ #category : #Running }
LogicTests >> runCase [
	"Run the case. Overridden to inform the notifier before and after this happens."

	
	self logicTimer beforeCaseDo: self.
	super runCase.
	self logicTimer afterCaseDo: self
]

{ #category : #Private }
LogicTests >> runCaseSelectorTimed [
	"like the general runcase, but timed"

	
	self setUp.
	[self resetTotal.
	self perform: testSelector sunitAsSymbol.
	Transcript
		show: testSelector;
		show: ': took ';
		print: self currentTotal;
		show: ' ms';
		cr] sunitEnsure: [self tearDown]
]
