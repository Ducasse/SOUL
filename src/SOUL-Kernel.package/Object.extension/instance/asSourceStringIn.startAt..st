*SOUL-Kernel
asSourceStringIn: anEnv startAt: index
	"this necessary to make quotedcode work when some variables are already filled in, because of an earlier downing process"

	
	^self asSourceString