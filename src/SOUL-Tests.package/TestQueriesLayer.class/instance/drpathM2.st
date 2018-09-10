slg tests
drpathM2

tabled drpath(?X,?Y) if 
	edge(?X,?Y).
tabled drpath(?X,?Y) if 
	drpath(?X,?Z),drpath(?Z,?Y)