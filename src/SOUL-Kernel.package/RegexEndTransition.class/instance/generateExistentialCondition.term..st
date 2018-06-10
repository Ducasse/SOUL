private
generateExistentialCondition: identifier term: aTerm
	
	^' if ' , 'goal' , identifier asString , '(' , from goalId asString ,
			',?phi, ?evalIn)'