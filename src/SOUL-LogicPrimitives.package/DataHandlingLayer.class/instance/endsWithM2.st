soul auto saved
endsWithM2

"tested on 10/09/2001

endsWith(+?String,+?Postfix) checks whether a given ?String ends with some ?Postfix
	 Both arguments are supposed to be instantiated upon calling this predicate. Warning:
	 the predicate is case-INsensitive, in other words it makes no distinction between capitals
	 and non-capitals when comparing strings.

Implementation note: the reason for the case-insensitivity has to do with the lower-level
	 Smalltalk primitive (i.e. #match:) that was used to implement this predicate. It was no
	 deliberate design decision for the predicate."

endsWith(?AString,?APostfix) if 
	or(var(?AString),var(?APostfix)),error(['endsWith/2 was called with one or both arguments variable!']).
endsWith(?AString,?APostfix) if 
	['*' , ?APostfix match: ?AString]