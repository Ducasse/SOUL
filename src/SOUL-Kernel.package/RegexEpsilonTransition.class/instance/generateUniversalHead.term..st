private
generateUniversalHead: identifier term: aTerm
	
	^'npatternUniversal' , identifier asString , '(?phi, '
		, from goalId asString , ',' , to goalId asString ,
			',?evalIn, ?evalIn, ?fromWorld, ?fromWorld)'