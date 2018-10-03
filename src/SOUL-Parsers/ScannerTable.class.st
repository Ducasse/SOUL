"
I hold the table that the Scanner or similar application uses to look up characters by character value.  If the character value is out of range, I answer one of several default values, depending on how the character classifies itself.

Instance Variables:
	value0	<Object>  ""an explicit entry for index=0""
	defaultValue	<Object>  ""the value for undefined characters""
	letterValue	<Object>  ""the default value for letters""
	digitValue	<Object>  ""the default value for digits""
	separatorValue	<Object>  ""the default value for separators (whitespace)""

Note that we have to override at:put: to make the defaulting mechanism work properly, because at: and at:put: both send subscriptBoundsError:, which loses both the information as to which message was sent and (in the case of at:put:) what value was being stored.  This is a design bug in the implementation of at: and at:put:.
"
Class {
	#name : #ScannerTable,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'value0',
		'defaultValue',
		'letterValue',
		'digitValue',
		'separatorValue'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'accessing-defaults' }
ScannerTable >> atAllDigitsPut: value [
	" Set the value for all Characters
	that identify themselves as digits
	and that are outside the range of
	explicitly stored indices. "

	
	digitValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isDigit ifTrue: [self at: index put: value]]
]

{ #category : #'accessing-defaults' }
ScannerTable >> atAllLettersPut: value [
	" Set the value for all Characters
	that identify themselves as letters
	and that are outside the range of
	explicitly stored indices. "

	
	letterValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isLetter ifTrue: [self at: index put: value]]
]

{ #category : #'accessing-defaults' }
ScannerTable >> atAllPut: value [
	
	value0 := defaultValue := letterValue := digitValue := separatorValue := value.
	^super atAllPut: value
]

{ #category : #'accessing-defaults' }
ScannerTable >> atAllSeparatorsPut: value [
	" Set the value for all Characters
	that identify themselves as separators
	and that are outside the range of
	explicitly stored indices. "

	
	separatorValue := value.
	0
		to: self size
		do:
			[:index | (Character value: index) isSeparator ifTrue: [self at: index put: value]]
]

{ #category : #'accessing-defaults' }
ScannerTable >> atDefaultPut: value [
	" Set the value for all Characters
	that are not letters and that are
	outside the range of explicitly stored
	indices. "

	
	defaultValue := value
]

{ #category : #'error handling' }
ScannerTable >> subscriptBoundsErrorFor: selector index: index [
	"This method is invoked when a subscript is an integer but is out of range.
	 Answer an appropriate default value."

	
	| char |
	index = 0 ifTrue: [^value0].
	(index
		between: self size + 1
		and: Character maxValue)
		ifFalse: [^super subscriptBoundsErrorFor: selector index: index].
	char := Character value: index.
	char isLetter ifTrue: [^letterValue].
	char isSeparator ifTrue: [^separatorValue].
	char isDigit ifTrue: [^digitValue].
	^defaultValue
]

{ #category : #'error handling' }
ScannerTable >> subscriptBoundsErrorFor: selector index: index value: aValue [
	"This method is invoked when a subscript is an integer
	 but is out of range during an at:put:.  If the index is zero
	 assign the zero value, otherwise raise an error."

	
	index = 0 ifTrue: [^value0 := aValue].
	^super subscriptBoundsErrorFor: selector index: index value: aValue
]
