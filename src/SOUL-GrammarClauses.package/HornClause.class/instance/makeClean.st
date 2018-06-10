resolving
makeClean
	"produce a clean copy of this clause (variables having a proper memory 
	location) "

	
	| fixer |
	fixer := FixVisitor new.
	self fixClean: fixer.
	self setEnvSize: fixer maxIndex + 1