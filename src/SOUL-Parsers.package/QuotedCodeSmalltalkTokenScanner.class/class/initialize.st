class initialization
initialize
	"Scanner initialize"

	"Spacing underbar ($_), which was the assignment character
	up through Release 4.0 of Smalltalk, has been adopted as a
	valid character for variable names and message selectors."

	
	| newTable |
	newTable := ScannerTable new: 256 withAll: #xdoIt.	"default"

	newTable atAll: #(9 10 12 13 32 ) put: #xDelimiter. "tab lf ff cr space"
	newTable atAllDigitsPut: #xDigit.
	newTable atAllLettersPut: #xLetter.
	newTable
		at: $_ asInteger
		put: #xLetter.
	newTable
		at: Character space asInteger
		put: #xspace.
	newTable
		at: Character tab asInteger
		put: #xspace.
	'!%&*+,-/<=>\~'
		do:
			[:bin | 
			newTable
				at: bin asInteger
				put: #xBinary].
	#(16rB1 16rD7 16rB7 16rF7) do: [:bin | newTable at: bin put: #xBinary].	"plus-or-minus"
	"times"
	"centered dot"
	"divide"
	"Other multi-character tokens"

	newTable
		at: $? asInteger
		put: #xSoulVariable.
	newTable
		at: $@ asInteger
		put: #xSoulCompound.
	newTable
		at: $" asInteger
		put: #xDoubleQuote.
	newTable
		at: $$ asInteger
		put: #xDollar.	"dollar sign"

	newTable
		at: $' asInteger
		put: #xSingleQuote.	"Single-character tokens"

	newTable
		at: $# asInteger
		put: #literalQuote.
	newTable
		at: $( asInteger
		put: #leftParenthesis.
	newTable
		at: $) asInteger
		put: #rightParenthesis.
	newTable
		at: $. asInteger
		put: #period.
	newTable
		at: $: asInteger
		put: #colon.
	newTable
		at: $; asInteger
		put: #semicolon.
	newTable
		at: $[ asInteger
		put: #leftBracket.
	newTable
		at: $] asInteger
		put: #rightBracket.
	newTable
		at: ${ asInteger
		put: #leftBrace.
	newTable
		at: $} asInteger
		put: #rightBrace.
	newTable
		at: $^ asInteger
		put: #upArrow.	"spacing circumflex, formerly up arrow"
	"Not currently supported.
	newTable at: 16r2191 put: #upArrow.  ""up arrow""
	newTable at: 16r2190 put: #leftArrow.  ""left arrow""
"

	newTable
		at: $| asInteger
		put: #verticalBar.
	QuotedCodeTypeTable := newTable