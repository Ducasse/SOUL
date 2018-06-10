resolving
verifyResultIsBoolean: result
	
	(result isKindOf: Boolean) 
		ifFalse:
			[self
				error:
					'predicate ' , functor asString ,
							' was sent as a message but answer was not a boolean']