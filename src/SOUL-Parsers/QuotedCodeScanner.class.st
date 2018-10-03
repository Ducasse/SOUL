Class {
	#name : #QuotedCodeScanner,
	#superclass : #SmaCCScanner,
	#category : 'SOUL-Parsers'
}

{ #category : #'signal constants' }
QuotedCodeScanner class >> errorSignal [
	
	^SoulParseError
]

{ #category : #scanning }
QuotedCodeScanner >> compound [
	
	| token |
	self scanUpTo: $( ignore: $@.
	self scanUpTo: $) ignore: $(.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self compoundId).
	matchActions := nil.
	returnMatchBlock value: token
]

{ #category : #generated }
QuotedCodeScanner >> compoundId [
	^ 6
]

{ #category : #generated }
QuotedCodeScanner >> emptySymbolTokenId [
	^ 18
]

{ #category : #generated }
QuotedCodeScanner >> errorTokenId [
	^ 19
]

{ #category : #scanning }
QuotedCodeScanner >> innerScanUpTo: stopChar ignore: startChar [
	
	| level |
	level := 0.
	[currentCharacter = stopChar and: [level = 0]]
		whileFalse:
			[currentCharacter = startChar ifTrue: [level := level + 1].
			currentCharacter = stopChar ifTrue: [level := level - 1].
			self atEnd
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self step]]
]

{ #category : #generated }
QuotedCodeScanner >> scanForToken [
	self step.
	currentCharacter == Character space
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $'
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $?
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(3).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $@
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $\
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(4).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
			^ self reportLastMatch ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self recordAndReportMatch: #(1 2) ].
	^ self recordAndReportMatch: #(1)
]

{ #category : #scanning }
QuotedCodeScanner >> scanUpTo: stopChar ignore: startChar [
	
	| level |
	level := 0.
	self step.
	[currentCharacter = stopChar and: [level = 0]]
		whileFalse:
			[currentCharacter = startChar ifTrue: [level := level + 1].
			currentCharacter = stopChar ifTrue: [level := level - 1].
			currentCharacter = $# ifTrue: [self step].
			currentCharacter = $'
				ifTrue:
					[self step.
					self innerScanUpTo: $' ignore: nil].
			currentCharacter = $$ ifTrue: [self step].
			self atEnd
				ifTrue: [self error: 'Unmatched ' , startChar asString]
				ifFalse: [self step]]	"self getNextChar."
	"self token: outputStream contents"
]

{ #category : #generated }
QuotedCodeScanner >> tokenActions [
	^ #(nil nil nil nil nil #compound)
]
