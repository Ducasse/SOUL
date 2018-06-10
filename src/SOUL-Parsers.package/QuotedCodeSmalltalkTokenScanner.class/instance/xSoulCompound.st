multi-character scans
xSoulCompound
	"form a SOUL compound"

	
	buffer reset.
	self getNextChar.
	self scanUpTo: $( ignore: $@.
	self scanUpTo: $) ignore: $(.
	token := buffer contents.
	tokenType := #xSoulCompound