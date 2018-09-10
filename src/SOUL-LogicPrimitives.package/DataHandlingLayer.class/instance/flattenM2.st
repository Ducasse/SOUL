soul auto saved
flattenM2

"tested on 22/08/2001

flatten(+?ListOfLists,+-?List) transforms a list of lists to a single list containing all
	 elements of each of the sublists of the original list of lists, in the same order.
	 The list of lists is supposed to be instantiated. The flattened list can either be
	 instantiated or not."

flatten(<>,<>).
flatten(<?First|?Rest>,?Result) if 
	flatten(?Rest,?FlatRest),append(?First,?FlatRest,?Result)