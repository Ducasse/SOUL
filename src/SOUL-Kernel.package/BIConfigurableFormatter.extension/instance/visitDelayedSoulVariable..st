*SOUL-Kernel
visitDelayedSoulVariable: aSoulVariable
	
	codeStream
		nextPutAll:
			(SoulFactory current makeDelayedVariable name: aSoulVariable name)
				smalltalkBlockString