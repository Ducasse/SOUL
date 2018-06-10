private
generateExistentialHead: identifier term: aTerm
	
	^'npattern' , identifier asString , '(?phi, ' , from goalId asString , ','
		, to goalId asString , ',?evalIn, ?evalIn, ?fromWorld, ?fromWorld, ?processedPath, ?differenceVariable, ?restPath, ?differenceVariable, ?restPath) '