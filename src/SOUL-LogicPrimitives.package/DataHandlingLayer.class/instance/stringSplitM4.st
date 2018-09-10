soul auto saved
stringSplitM4

"tested on 28/08/2001

stringSplit(+?String,+?SubString,+-?Before,+-?After) computes the part of ?String that
	 can be found ?Before and ?After a given ?Substring. 
	 More than one solution is possible if ?SubString occurs more than one time in ?String.
	 The variables ?String and ?SubString are not allowed to be unbound variables when
	 this predicate is called. Both ?Before and ?After can either be variable or not.
	 ?SubString is supposed to be non-empty, otherwise the predicate will fail.

Implementation note: The predicate is implemented by using a piece of Smalltalk code
	 which generates all possible positions in the string where the substring is located."

stringSplit(?AString,?SubString,?Before,?After) if 
	or(var(?AString),var(?SubString)),error(['stringSplit/4 was called with first and/or second argument variable!']).
stringSplit(?AString,?SubString,?Before,?After) if 
	member(?Index,[| index allIndexes |
index := 0.
allIndexes := OrderedCollection new.
[index := ?AString
	findString: ?SubString
	startingAt: index + 1.
index == 0] whileFalse: [allIndexes add: index].
allIndexes]),equals(?Before,[?AString
	speciesCopyFrom: 1
	to: ?Index - 1]),equals(?After,[?AString
	speciesCopyFrom: ?Index + ?SubString size
	to: ?AString size])