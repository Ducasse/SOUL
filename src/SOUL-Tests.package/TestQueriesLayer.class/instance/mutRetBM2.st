slg tests
mutRetBM2

tabled mutRetB(?X,?Y) if 
	mutRetC(?X,?Y).
tabled mutRetB(?X,?Y) if 
	mutRetA(?X,?Z),mutRetD(?Z,?Y)