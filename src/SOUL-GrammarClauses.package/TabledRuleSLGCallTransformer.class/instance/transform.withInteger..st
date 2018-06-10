accessing
transform: vars withInteger: anInteger
	
	| slgcallString |
	slgcallString := 'slgcall' , '(?Id, ' , vars asString , ','
		, tabledCall printString ,
			',[ Array with: (OrderedCollection new) with: (OrderedCollection new) ],'
		, 'cont' , anInteger asString
		, (tabledRule predicate asString reject: [:x | x = $:]) , ')'.
	^slgcallString