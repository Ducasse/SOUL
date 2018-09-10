slg tests
slgmanualpathM3

slgmanualpath(?x,?y,?Id) if 
	slgcall(?Id,?vars,manualpath(?x,?z),0,manualpathcont0).
slgmanualpath(?x,?y,?Id) if 
	edge(?x,?y),answer(?Id,manualpath(?x,?y),0)