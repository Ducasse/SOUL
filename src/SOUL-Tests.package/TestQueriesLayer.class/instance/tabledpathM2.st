slg tests
tabledpathM2

tabled tabledpath(?x,?y) if 
	tabledpath(?x,?z),edge(?z,?y).
tabled tabledpath(?x,?y) if 
	edge(?x,?y)