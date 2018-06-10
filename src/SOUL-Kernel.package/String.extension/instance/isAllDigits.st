*SOUL-Kernel
isAllDigits
	"whether the receiver is composed entirely of digits"

	
	^self size > 0 and:[(self contains: [:c | c isDigit not]) not]