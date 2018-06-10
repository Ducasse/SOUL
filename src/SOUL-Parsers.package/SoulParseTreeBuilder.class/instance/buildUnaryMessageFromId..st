building SOUL
buildUnaryMessageFromId: id
	
	^SoulFactory current makeUnaryMessageFunctor message: (self buildConstant: id)