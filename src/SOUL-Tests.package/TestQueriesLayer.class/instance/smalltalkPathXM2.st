slg tests
smalltalkPathXM2

tabled ?x smalltalkPath: ?y if 
	edge(?x,?y).
tabled ?x smalltalkPath: ?y if 
	edge(?x,?z),?z smalltalkPath: ?y