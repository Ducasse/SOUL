soul auto saved
sameElementsM2

"tested on 05-07-2001

Returns whether two lists have the same elements. 
	The order of the elements is not important"

sameElements(?list1,?list2) if 
	list(?list1),list(?list2),subSetOf(?list1,?list2),subSetOf(?list2,?list1).
sameElements(?list1,?list2) if 
	or(and(var(?list1),list(?list2)),and(list(?list1),var(?list2))),equals(?list1,?list2)