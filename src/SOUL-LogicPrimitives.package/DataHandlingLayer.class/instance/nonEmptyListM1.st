soul auto saved
nonEmptyListM1

"tested on 28/08/2001

nonEmptyList(+?List) checks whether ?List is a non-empty list. The argument is supposed
	 to be instantiated.

Implementation note: the order of the predicants in the rule below is important."

nonEmptyList(?List) if 
	var(?List),error(['nonEmptyList/1 was called with a variable argument!']).
nonEmptyList(?List) if 
	not(emptyList(?List)),list(?List)