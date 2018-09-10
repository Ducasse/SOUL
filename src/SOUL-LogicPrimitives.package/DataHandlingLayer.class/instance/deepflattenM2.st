soul auto saved
deepflattenM2

"tested on 09-07-2001

deepflatten(+?ListOfNestedLists,+-?List) transforms a list of lists (which can again contain
	 lists, and so on) to a single list containing all elements of each of the sublists of the
	 original list of lists, in the same order. The list of nested lists that is provided as input
	 is supposed to be instantiated."

deepflatten(<>,<>).
deepflatten(?Item,<?Item>) if 
	not(list(?Item)).
deepflatten(?ListOfNestedLists,?List) if 
	nonvar(?ListOfNestedLists),equals(?ListOfNestedLists,<?First|?Rest>),deepflatten(?First,?FlatFirst),deepflatten(?Rest,?FlatRest),append(?FlatFirst,?FlatRest,?List)