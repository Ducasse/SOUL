slg tests
shortpathM2

tabled shortpath(?X,?Y) if 
	shortedge(?X,?Y).
tabled shortpath(?x,?y) if 
	shortpath(?x,?z),shortedge(?z,?y)