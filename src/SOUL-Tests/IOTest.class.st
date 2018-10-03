Class {
	#name : #IOTest,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #output }
IOTest >> testnewline [
	"self run: #testnewline"

	"newline/0"

	
	self processQuery: ' if succeeds(newline(?dummy))' description:
			'Does this bring the cursor to a new line on the Transcript?'
]

{ #category : #'printing on Transcript' }
IOTest >> testprologoutput [
	"newline/0"

	"write/1"

	"writeLn/1"

	"This test should print out the following on the Transcript: 
	Language: It`s a virus. 
	-- Laurie Anderson.
	"

	
	self processQuery:
			' if succeeds(and(write([''Language: It`s a virus.'']),newline(?dummy),writeLn([''-- Laurie Anderson.'']),write([''The above should have printed nice!''])))'
		description: 'Does this print something nice on the Transcript?'
]

{ #category : #output }
IOTest >> testwrite [
	"self run: #testwrite"

	"write/1"

	
	self processQuery: ' if succeeds(write(hello))' description:
			'Does this print the string hello on the Transcript?'
]

{ #category : #output }
IOTest >> testwriteLn [
	"self run: #testwriteLn"

	"writeLn/1"

	
	self processQuery: ' if succeeds(writeLn(hello))' description:
			'Does this print the string hello on the Transcript and then go to a new line?'
]

{ #category : #output }
IOTest >> testwriteLnLst [
	"self run: #testwriteLnLst"

	"writeLnLst/1"

	
	self processQuery: ' if succeeds(writeLnLst(<a,b,c>))' description:
			'Does this write the elements a, b, c on separate lines of the Transcript?'
]

{ #category : #output }
IOTest >> testwriteLst [
	"self run: #testwriteLst"

	"writeLst/1"

	
	self processQuery: ' if succeeds(writeLst(<a,b,c>))' description:
			'Does this write the elements a, b, c one after the other on the Transcript?'
]

{ #category : #output }
IOTest >> testwriteLstLn [
	"self run: #testwriteLstLn"

	"writeLstLn/1"

	
	self processQuery: ' if succeeds(writeLstLn(<a,b,c>))' description:
			'Does this write the elements a, b, c one after the other on the Transcript and then go to a new line?'
]
