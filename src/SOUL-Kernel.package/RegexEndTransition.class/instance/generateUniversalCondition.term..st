private
generateUniversalCondition: identifier term: aTerm
	
	^' if forall(goal' , identifier asString , '(' , from goalId asString ,
			',?phi, ?evalIn))'