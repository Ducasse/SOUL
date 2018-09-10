soul auto saved
atomToCharsM2

"atomToChars(+?Atom, +-?CharList) transforms an ?Atom to a ?CharList. The current implementation only works when ?Atom is bound to an atom. ?CharList on the other hand may or may not be variable.

CASE 1: atomToChars(+?Atom, -?CharList)"

atomToChars(?Atom,?CharList) if 
	atom(?Atom),var(?CharList),stringOrAtomToChars(?Atom,?CharList).
"CASE 2: atomToChars(+?Atom, +?CharList)"

atomToChars(?Atom,?CharList) if 
	atom(?Atom),nonvar(?CharList),atomToChars(?Atom,?AtomAsCharList),equals(?CharList,?AtomAsCharList)