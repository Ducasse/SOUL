Class {
	#name : #SmalltalkTermScanner,
	#superclass : #SmaCCScanner,
	#category : 'SOUL-Parsers'
}

{ #category : #'generated-initialization' }
SmalltalkTermScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(20 'false' 12) #(20 'nil' 14) #(20 'true' 11) #(26 '||' 15))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
SmalltalkTermScanner >> binarysymbolId [
	^ 26
]

{ #category : #generated }
SmalltalkTermScanner >> emptySymbolTokenId [
	^ 66
]

{ #category : #generated }
SmalltalkTermScanner >> errorTokenId [
	^ 67
]

{ #category : #generated }
SmalltalkTermScanner >> nameId [
	^ 20
]

{ #category : #scanning }
SmalltalkTermScanner >> negativenumber [
	
	stream skip: -2.
	self scanNumber: self negativenumberId 
]

{ #category : #generated }
SmalltalkTermScanner >> negativenumberId [
	^ 22
]

{ #category : #scanning }
SmalltalkTermScanner >> number [
	
	stream skip: -1.
	self scanNumber: self numberId
]

{ #category : #generated }
SmalltalkTermScanner >> numberId [
	^ 21
]

{ #category : #generated }
SmalltalkTermScanner >> scan1 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan2 ].
	true ] whileTrue
]

{ #category : #generated }
SmalltalkTermScanner >> scan2 [
	self recordMatch: #(23).
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scan3 [
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan3 ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scan4 [
	self recordMatch: #(24).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scan5 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(25).
			self step.
			((currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForToken [
	self step.
	currentCharacter == $"
		ifTrue:
			[ ^ self scanForTokenX9 ].
	currentCharacter == $#
		ifTrue: [ ^ self recordAndReportMatch: #(1 34) ].
	currentCharacter == $$
		ifTrue:
			[ ^ self scanForTokenX12 ].
	currentCharacter == $&
		ifTrue:
			[ ^ self scanForTokenX2 ].
	currentCharacter == $'
		ifTrue:
			[ ^ self scanForTokenX11 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(10 34) ].
	^ self scanForTokenX15
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX1 [
	self recordMatch: #(26 34).
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(32).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX10 [
	self recordMatch: #(18 34).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX11 [
	self recordMatch: #(34).
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan2 ].
	^ self scan1
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX12 [
	self recordMatch: #(34).
	self step.
	^ self recordAndReportMatch: #(30)
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX13 [
	true
		ifTrue: [ self recordMatch: #(26 34).
			self step.
			(currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $,)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ])
				ifTrue: [ ^ self recordAndReportMatch: #(26) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX14 [
	currentCharacter == $|
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(8 34) ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self recordAndReportMatch: #(21 34) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX8 ].
	currentCharacter isSafeForHTTP
		ifTrue:
			[ ^ self scanForTokenX4 ].
	(currentCharacter isArrow
		or: [ currentCharacter <= Character backspace
				or: [ (currentCharacter
						between: (Character value: 14)
						and: Character escape)
						or: [ currentCharacter == $`
								or: [ currentCharacter >= (Character value: 127) ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(34) ].
	^ self scanForTokenX13
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX15 [
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(4 34) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(5 34) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scanForTokenX10 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(2 34) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $>
		ifTrue:
			[ ^ self scanForTokenX6 ].
	currentCharacter == $?
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17 34) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(19 34) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(16 34) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(3 34) ].
	^ self scanForTokenX14
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX2 [
	self recordMatch: #(26 34).
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(33).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX3 [
	self recordMatch: #(26 34).
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX4 [
	self recordMatch: #(20 34).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan4 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan3 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan4 ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX5 [
	self recordMatch: #(9 26 34).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX6 [
	self recordMatch: #(7 26 34).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX7 [
	self recordMatch: #(6 26 34).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX8 [
	self recordMatch: #(27 34).
	self step.
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(27).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
SmalltalkTermScanner >> scanForTokenX9 [
	self recordMatch: #(34).
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	true
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(28) ].
			true ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #scanning }
SmalltalkTermScanner >> scanNumber: id [
	
	| token number |
	number := Number readFrom: stream.
	outputStream reset.
	token := SmaCCToken
		value: number
		start: start
		id: (Array with: id).
	matchActions := nil.
	returnMatchBlock value: token
]

{ #category : #generated }
SmalltalkTermScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #number #negativenumber nil nil nil nil #whitespace #comment nil nil #variableassignment)
]

{ #category : #scanning }
SmalltalkTermScanner >> variableassignment [
	
	| token |
	outputStream skip: -2.
	stream skip: -2.
	token := SmaCCToken
		value: outputStream contents
		start: start
		id: (Array with: self nameId).
	outputStream reset.
	matchActions := nil.
	returnMatchBlock value: token
]
