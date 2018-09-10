evaluator
testNestedFindall
	
	self
		processQuery:
			' if findall(?xs,findall(?x,fooTest(?x),?xs),?ys),equals(?ys,<<1,2>>)'
		description: 'Nested findall test'
		repository: self repository