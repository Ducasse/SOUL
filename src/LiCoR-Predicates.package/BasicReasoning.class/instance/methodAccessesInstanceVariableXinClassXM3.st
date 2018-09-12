method body
methodAccessesInstanceVariableXinClassXM3

"?Method of ?Class either reads or writes ?Variable
CASE 1: the method assigns"

?Method methodAccessesInstanceVariable: ?Variable inClass: ?class if 
	?Method methodAssignsInstanceVariable: ?Variable inClass: ?class.
"?Method of ?Class either reads or writes ?Variable
CASE 2: the method reads"

?Method methodAccessesInstanceVariable: ?Variable inClass: ?class if 
	?Method methodReadsInstanceVariable: ?Variable inClass: ?class