soul auto saved
reverseM2

"tested on 28/08/2001

reverse(+?List,+-?ReversedList)
	 reverse(-?List,+?ReversedList)
	 reverses a given list. At most one argument may be uninstantiated."

reverse(?List,?ReversedList) if 
	var(?List),var(?ReversedList),error(['reverse/2 was called with both arguments variable!']).
reverse(?List,?ReversedList) if 
	reverse(?List,<>,?ReversedList)