resolving
resolveIn: anEnv startAt: anIndex
	"This method gets invoked by the kernel to start a resolution process with this term as a goal"

	
	self error: 'Cannot resolve a ' , self class asString