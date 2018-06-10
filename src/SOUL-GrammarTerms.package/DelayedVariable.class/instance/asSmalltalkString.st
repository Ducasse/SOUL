converting
asSmalltalkString
	"see comment in AbstractTerm"

	
	^'(env transitiveLookup: soulvar' , self name , ')'