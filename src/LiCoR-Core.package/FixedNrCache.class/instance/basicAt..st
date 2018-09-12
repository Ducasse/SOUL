private
basicAt: aKey
	
	^self elements
		at: aKey
		ifAbsent:
			[self halt: 'Element Does not Exists in Cache... '.
			^self]