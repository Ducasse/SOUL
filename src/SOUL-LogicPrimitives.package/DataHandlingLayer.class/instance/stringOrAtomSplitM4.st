soul auto saved
stringOrAtomSplitM4

"stringOrAtomSplit(+?StringOrAtom,+?SubStringOrAtom,+-?BeforeString,+-?AfterString) is the same as stringSplit/4, but
also works for atoms. It computes the part of StringOrAtom that can be found before and after a given substring (or atom).
(More than one solution is possible if SubStringOrAtom occurs more than one time in StringOrAtom).
USAGE NOTE: The variables StringOrAtom and SubStringOrAtom are not allowed to be unbound variables when this
predicate is called.

Implementation note: in fact we do not need to handle the case for atoms separately. Apparently this case is already
handled automatically due to an automatic conversions of Smalltalk atoms to Smalltalk strings. So we can just use the
stringSplit predicate instead. In fact, this predicate stringOrAtomSplit is thus not really needed anymore, but is still here
because it might be called by other predicates."

stringOrAtomSplit(?StringOrAtom,?SubStringOrAtom,?BeforeString,?AfterString) if 
	stringSplit(?StringOrAtom,?SubStringOrAtom,?BeforeString,?AfterString)