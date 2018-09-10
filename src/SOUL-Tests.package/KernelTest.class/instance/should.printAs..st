parser-printer
should: expression1 printAs: expression2
	
	| representation |
	representation := SoulFactory current makeParser parse: expression1.
	self assert: representation printString = expression2