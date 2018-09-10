soul auto saved
intersectionListsM2

"tested

Get a list with the common elements in a list of lists. For example:
		intersectionLists(<<[1],[2],[42]>,<[2],[3],[42]>,<[3],[4],[42]>>, <[42]>)

Passing variables as lists, or even variables within the lists, is NOT allowed."

intersectionLists(?lists,?intersectionList) if 
	forall(member(?list,?lists),ground(?list)),privateIntersectionLists(?lists,?intersectionList)