soul auto saved
appendAtomsM3

"appendAtoms/3(+?A1,+?A2,+-?A3) concatenates 2 atoms or strings ?A1 and ?A2 into a third ?A3"

appendAtoms(?Atom1,?Atom2,?Atom3) if 
	atom(?Atom1),atom(?Atom2),equals(?Atom3,[(?Atom1 , ?Atom2) asSymbol]).
appendAtoms(?Atom1,?Atom2,?Atom3) if 
	not(and(atom(?Atom1),atom(?Atom2))),error(['appendAtoms/3 requires the two first arguments to be atoms!'])