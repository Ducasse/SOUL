soul auto saved
unionM3

"reimplemented by Tom Mens to make it more consistent with the definitions of the oher set handling operators

tested on 22/08/2001

union(+?Set1,+?Set2,+-?Union) computes the ?Union of two sets ?Set1 and ?Set2.
	 Both ?Set1 and ?Set2 are supposed to be instantiated. ?Union can either be instantiated
	 or not. The order of the elements in the ?Union is the order of which the elements
	 occur in ?Set1 and ?Set2 respectively.

Note: the implementation below is a rather slow one, because noDups/2 is very slow.

Old implementation was:
union(?Set1,?Set2,?Union) if
	append(?Set1,?Set2,?UnionWithDups),
	noDups(?UnionWithDups,?Union).

"

union(?Set1,?Set2,?Union) if 
	findall(?El,or(includes(?El,?Set1),includes(?El,?Set2)),?UnionWithDups),noDups(?UnionWithDups,?Union)