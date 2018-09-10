soul auto saved
writeM1

"tested on 08/07/2001

write(?Something) writes the string representation of ?Something on the Transcript."

write(?Something) if 
	[Transcript show: ?Something asString.
true]