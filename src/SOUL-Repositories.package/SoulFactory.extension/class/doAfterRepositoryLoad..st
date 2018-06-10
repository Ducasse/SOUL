*SOUL-Repositories
doAfterRepositoryLoad: aBlock
	
	(Repositories at: #default) == nil
		ifTrue: [self addToWaitList: aBlock]
		ifFalse: [aBlock value]