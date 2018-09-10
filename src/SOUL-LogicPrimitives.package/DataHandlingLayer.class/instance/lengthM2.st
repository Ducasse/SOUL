soul auto saved
lengthM2

"partially converted

tested

only works if the list if a real list, does not work when list is a variable

get the length of a list
 If Term is a list, Length will be unified with the number of items in the list. 
 If Length is an integer and Term is unbound, Term will be unified with a list of 
 variables of the specified Length."

length(<>,[0]).
length(<?car|?cdr>,-?length) if 
	length(?cdr,?x),equals(?length,[?x + 1]).
"Warning: ?l of length(?l, 3) may print as <?car, ?car, ?car>, but the ?car named variables are distinct in reality"

length(<?car|?cdr>,+?length) if 
	[?length > 0],length(?cdr,[?length - 1])