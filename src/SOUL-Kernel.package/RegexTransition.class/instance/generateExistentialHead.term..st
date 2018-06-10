private
generateExistentialHead: identifier term: aTerm
	
	^'npattern' , identifier asString , '(?phi, ' , from goalId asString , ','
		, to goalId asString , ',?evalIn, ?nextEvalIn, ?fromWorld, ?toWorld, ?processedPath, <? evalIn | ?newDifferenceVariable >, <?evalIn | ?restPath >, ?newDifferenceVariable, ?restPath ) '