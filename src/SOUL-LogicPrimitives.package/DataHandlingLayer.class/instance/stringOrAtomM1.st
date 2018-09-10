soul auto saved
stringOrAtomM1

"not tested

stringOrAtom(+-?Something) checks whether ?Something is a Smalltalk string or QSOUL atom.

Implementation note: in QSOUL, strings are considered as a special kind of atoms."

stringOrAtom(?StringOrAtom) if 
	atom(StringOrAtom)