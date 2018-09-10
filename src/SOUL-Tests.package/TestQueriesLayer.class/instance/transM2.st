ctl
transM2

trans(s1,s1).
trans(s0,s2).
trans(s2,s0).
trans(s2,s1).
trans(s0,s1).
"prevent our testqueries from messing with the versionmodel"

trans(?X,?Y) if 
	!,[false]