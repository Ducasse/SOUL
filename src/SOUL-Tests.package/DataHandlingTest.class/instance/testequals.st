term comparison and sorting
testequals
	"equals/2"

	
	self processQuery: ' if succeeds(equals([#add:],[#add:]))' description:
			'Are two equal Smalltalk symbols the same?'.
	self processQuery: ' if succeeds(equals([#test],test))' description:
			'Are a Smalltalk symbol and its corresponding logic term equal?'.
	self processQuery: ' if succeeds(equals([1],[1.0]))' description:
			'Is the integer 1 equal to the real number 1.0?'.
	self processQuery: ' if succeeds(and(equals(?X,?Y),var(?X),var(?Y)))'
		description: 'Can a variable be unified with another variable?'.
	self processQuery:
			' if succeeds(and(equals(?X,?Y),equals(?X,1),equals(?Y,1)))'
		description:
			'After unifying two variables and assigning a value to one of them, does the other one automatically get bound to the same value?'.
	self processQuery: ' if succeeds(equals(?X,[#add:]))' description:
			'Can a variable be unified with a value?'.
	self processQuery: ' if succeeds(equals([#add:],?Y))' description:
			'Can a value be unified with a variable?'.
	self processQuery: ' if succeeds(equals([#add],add))' description:
			'Is a Smalltalk symbol equal to the corresponding logic constant?'.
	self processQuery: ' if succeeds(equals(add,add))' description:
			'Are two equal logic constants (symbols) unified?'.
	self processQuery: ' if succeeds(equals(1,1))' description:
			'Are two equal logic constants (integers) unified?'.
	self processQuery: ' if succeeds(equals([1],1))' description:
			'Is a Smalltalk integer equal to the corresponding logic constant?'.
	self processQuery: ' if succeeds(equals([1.0],1))' description:
			'Is a Smalltalk integer in real form equal to the corresponding logic constant?'.
	self processQuery: ' if fails(equals([#add:],[#add]))' description:
			'Are two different Smalltalk symbols unequal?'.
	self processQuery: ' if succeeds(equals(<kim,tom>,<kim,tom>))'
		description:
			'Are two equal lists equal unregarding their external representation?'.
	self processQuery: ' if fails(equals(<kim,tom>,<tom,kim>))' description:
			'Are two unequal lists with different representation unequal?'.
	self processQuery: ' if fails(equals(<kim,tom>,<tom,kim>))' description:
			'Are two unequal lists with same representation unequal?'.
	self processQuery:
			' if succeeds(and(equals(?X,<x,y,z,u,v>),equals(<x,y,z,u,v>,?X)))'
		description: 'Can a variable be unified with a list?'.
	self processQuery: ' if succeeds(equals(<x,y,z,u,v>,<x,y,z,u,v>))'
		description:
			'Is a list in shorthand notation equal to its expanded form?'