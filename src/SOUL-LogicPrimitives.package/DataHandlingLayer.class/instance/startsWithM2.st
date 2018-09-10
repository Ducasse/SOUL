soul auto saved
startsWithM2

"tested on 28/08/2001

startsWith(+?String,+?Prefix) checks whether a given ?String starts with some ?Prefix
	 Both arguments are supposed to be instantiated upon calling this predicate. Warning:
	 the predicate is case-INsensitive, in other words it makes no distinction between capitals
	 and non-capitals when comparing strings.

Implementation note: the reason for the case-insensitivity has to do with the lower-level
	 Smalltalk primitive (i.e. #match:) that was used to implement this predicate. It was no
	 deliberate design decision for the predicate."

startsWith(?AString,?APrefix) if 
	or(var(?AString),var(?APrefix)),error(['startsWith/2 was called with one or both arguments variable!']).
startsWith(?AString,?APrefix) if 
	[?APrefix , '*' match: ?AString]