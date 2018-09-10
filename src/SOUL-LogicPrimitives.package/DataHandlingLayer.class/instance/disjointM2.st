soul auto saved
disjointM2

"tested on 22/08/2001

disjoint(+?Set1,+?Set2) verifies whether two sets ?Set1 and ?Set2 are disjoint.
	 Both ?Set1 and ?Set2 are supposed to be instantiated."

disjoint(?Set1,?Set2) if 
	forall(includes(?El,?Set1),not(includes(?El,?Set2)))