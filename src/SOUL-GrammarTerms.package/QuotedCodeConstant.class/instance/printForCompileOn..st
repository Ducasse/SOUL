printing
printForCompileOn: aStream
	"see comment in AbstractTerm"

	
	| x name |
	aStream write: self class name , ' name: '''.	"I should first convert every quote into a double quote"

	name := smalltalkValue asString.
	1
		to: name size
		do:
			[:i | 
			aStream write: (x := name at: i).
			x == $' ifTrue: [aStream write: x]].
	aStream write: ''''