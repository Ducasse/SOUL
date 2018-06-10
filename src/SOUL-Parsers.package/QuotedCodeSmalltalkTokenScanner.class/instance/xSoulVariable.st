multi-character scans
xSoulVariable
	"form a SOUL variable"

	
	| type  |
	buffer reset.
	"Start by saving the ? to the buffer"
	buffer nextPut: hereChar.
	[
	self step.
	hereChar ~~ DoItCharacter
		and:
			[type := typeTable at: hereChar asInteger.
			type == #xLetter or: [type == #xDigit]]]
		whileTrue: [buffer nextPut: hereChar].
	token := buffer contents.
	tokenType := #xSoulVariable