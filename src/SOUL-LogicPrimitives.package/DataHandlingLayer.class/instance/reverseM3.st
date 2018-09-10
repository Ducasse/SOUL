soul auto saved
reverseM3

reverse(<>,?ReversedList,?ReversedList).
reverse(<?Head|?Tail>,?ReversedSoFar,?ReversedList) if 
	reverse(?Tail,<?Head|?ReversedSoFar>,?ReversedList)