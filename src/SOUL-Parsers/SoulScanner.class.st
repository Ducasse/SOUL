Class {
	#name : #SoulScanner,
	#superclass : #SmaCCScanner,
	#instVars : [
		'commentText'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'generated-initialization' }
SoulScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(18 'if' 9) #(18 'tabled' 3) #(19 'matches:' 17))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #scanning }
SoulScanner >> comment [
	
	| newComment |
	newComment := outputStream contents copyReplaceAll: '""' with: '"'.
	newComment := newComment size > 2
		ifTrue:
			[newComment
				copyFrom: 2
				to: newComment size - 1]
		ifFalse: [''].
	commentText := (commentText
		ifNil: ['']
		ifNotNil:
			[commentText , (String with: Character cr) , (String with: Character cr)])
		, newComment.
	^super comment
]

{ #category : #generated }
SoulScanner >> emptySymbolTokenId [
	^ 65
]

{ #category : #generated }
SoulScanner >> errorTokenId [
	^ 66
]

{ #category : #scanning }
SoulScanner >> giveAndWipeComment [
	
	| hold |
	hold := commentText.
	commentText := nil.
	^hold
]

{ #category : #scanning }
SoulScanner >> innerScanUpTo: stopChar ignore: startChar [
	
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

{ #category : #scanning }
SoulScanner >> quoted [
	
	| token |
	self scanUpTo: $} ignore: ${.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self quotedId).
	matchActions := nil.
	returnMatchBlock value: token
]

{ #category : #generated }
SoulScanner >> quotedId [
	^ 28
]

{ #category : #generated }
SoulScanner >> scanForToken [
	self step.
	currentCharacter == $!
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $"
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(30) ].
			true ] whileTrue ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scanForTokenX5 ].
	^ self scanForTokenX10
]

{ #category : #generated }
SoulScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $-
		ifTrue: [ self step.
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(29) ].
			^ self reportLastMatch ].
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter == $?
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(25).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX10 [
	currentCharacter == $&
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $+
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $:
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $?
		ifTrue:
			[ ^ self scanForTokenX2 ].
	^ self scanForTokenX9
]

{ #category : #generated }
SoulScanner >> scanForTokenX2 [
	self recordMatch: #(26).
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(21).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self recordAndReportMatch: #(22) ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX3 [
	self step.
	currentCharacter == $?
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(24).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX4 [
	self recordMatch: #(1).
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(23).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX5 [
	self step.
	((currentCharacter between: $0 and: $:)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			(currentCharacter between: $0 and: $:)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX6 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX7 [
	self recordMatch: #(12).
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX8 [
	self step.
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	^ self reportLastMatch
]

{ #category : #generated }
SoulScanner >> scanForTokenX9 [
	currentCharacter == $@
		ifTrue:
			[ ^ self scanForTokenX8 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX6 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self recordAndReportMatch: #(19) ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #scanning }
SoulScanner >> scanUpTo: stopChar ignore: startChar [
	
	| level |
	level := 0.
	self atEnd ifTrue: [self error: 'Unmatched ' , startChar asString].
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

{ #category : #scanning }
SoulScanner >> stterm [
	
	| token |
	self scanUpTo: $] ignore: $[.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self sttermId).
	matchActions := nil.
	returnMatchBlock value: token
]

{ #category : #generated }
SoulScanner >> sttermId [
	^ 27
]

{ #category : #generated }
SoulScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #stterm #quoted nil #comment #whitespace)
]
