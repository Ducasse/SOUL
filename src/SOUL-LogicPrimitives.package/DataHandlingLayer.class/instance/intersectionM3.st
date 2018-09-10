soul auto saved
intersectionM3

"tested on 22/08/2001

intersection(+?Set1,+?Set2,+-?Intersection) computes the ?Intersection of two sets ?Set1 and
	 ?Set2. Both ?Set1 and ?Set2 are supposed to be instantiated. ?Intersection can either be
	 instantiated or not. It contains the computed intersection. The order of the elements in
	 the intersection will be the same as the order in which the corresponding elements
	 appear in ?Set1"

intersection(?Set1,?Set2,?Intersection) if 
	findall(?El,and(includes(?El,?Set1),includes(?El,?Set2)),?Intersection)