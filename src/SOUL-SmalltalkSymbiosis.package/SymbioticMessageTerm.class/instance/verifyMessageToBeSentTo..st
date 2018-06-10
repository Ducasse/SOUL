resolving
verifyMessageToBeSentTo: receiver
	
	(receiver class canUnderstand: functor messageSelector)
		ifFalse:
			[self
				error:
					functor asString ,
							' is not implemented as a rule nor is understood as a message by instances of '
						, receiver class name asString]