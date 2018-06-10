*SOUL-Kernel
visitSoulVariable: aSoulVariable
	
	codeStream
		nextPutAll:
			(SoulFactory current makeVariable name: aSoulVariable name)
				smalltalkBlockString