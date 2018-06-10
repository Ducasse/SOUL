*SOUL-Kernel
cachedSoulChildren
	
	cachedSoulChildren
		ifNil:
			[cachedSoulChildren := self soulChildren collect: [:aChild | aChild soulUp]].
	^cachedSoulChildren