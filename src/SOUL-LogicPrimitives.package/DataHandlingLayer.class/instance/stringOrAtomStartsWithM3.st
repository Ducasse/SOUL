soul auto saved
stringOrAtomStartsWithM3

"stringOrAtomStartsWith(+?StringOrAtom, ?Start, ?After) is the same as startsAndEndsWith/3, but
also works for atoms. It checks whether a ?StringOrAtom starts with a substring or atom ?Start,
and puts the remainder of the ?StringOrAtom in a string ?After.
USAGE NOTE: The variable StringOrAtom is not allowed to be an unbound variable when this predicate is called.

Implementation note: in fact we do not need to handle the case for atoms separately. Apparently this case is already
handled automatically due to an automatic conversions of Smalltalk atoms to Smalltalk strings. So we can just use the
startsAndEndsWith predicate instead. In fact, this predicate stringOrAtomStartsWith is thus not really needed anymore, but is still here
because it might be called by other predicates."

stringOrAtomStartsWith(?StringOrAtom,?Start,?After) if 
	startsAndEndsWith(?StringOrAtom,?Start,?After)