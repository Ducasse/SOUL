Class {
	#name : #ArithmeticTest,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #'basic arithmetic' }
ArithmeticTest >> testadd [
	"add/3"

	
	self processQuery:
			' if succeeds(and(add([8],[9],?resulta),equals(?resulta,[17])))'
		description: 'Is 8 + 9 = 17 ?'.
	self processQuery: ' if succeeds(and(add(?n1,[2],[-1]),equals(?n1,[-3])))'
		description: 'Is -3 the solution of the equation x + 2 = -1 ?'.
	self processQuery: ' if succeeds(and(add([3],?m1,[5]),equals(?m1,[2])))'
		description: 'Is 2 the solution of the equation 3 + x = 5 ?'.
	self processQuery: ' if succeeds(add([4],[5],[9]))' description:
			'Is 4 + 5 = 9 ?'.
	self processQuery: ' if succeeds(add([-1],[-2],[-3]))' description:
			'Is -1 + -2 = -3 ?'.
	self processQuery: ' if fails(add(?N,?M,?R))' description:
			'Does addition fail when all arguments are unbound?'.
	self processQuery: ' if fails(add([4],[5],[10]))' description:
			'Is 4 + 5 not equal to 10?'
]

{ #category : #'basic arithmetic' }
ArithmeticTest >> testadd1 [
	"add1/2"

	
	self processQuery: ' if succeeds(add1([8],[9]))' description:
			'Is 8 + 1 = 9 ?'.
	self processQuery: ' if fails(add1([9],[11]))' description:
			'Is 9 + 1 not equal to 11 ?'.
	self processQuery: ' if succeeds(and(add1(?n1,[2]),equals(?n1,[1])))'
		description: 'Is x = 1 if x + 1 = 2 ?'.
	self processQuery: ' if succeeds(and(add1([3],?m1),equals(?m1,[4])))'
		description: 'Is x = 4 if 3 + 1 = x ?'
]

{ #category : #comparison }
ArithmeticTest >> testcomparable [
	"comparable/2"

	
	self processQuery: ' if fails(comparable([Object],[1]))' description:
			'Is Object not comparable with a number ?'.
	self processQuery: ' if succeeds(comparable([2],[1]))' description:
			'Is an integer comparable with another integer ?'.
	self processQuery: ' if succeeds(comparable([2.0],[1]))' description:
			'Is an integer comparable with a real ?'
]

{ #category : #comparison }
ArithmeticTest >> testgreater [
	"greater/2"

	
	self processQuery: ' if succeeds(greater([6],[5]))' description:
			'Is 6 greater than 5 ?'.
	self processQuery: ' if fails(greater([5],[6]))' description:
			'Is 5 not greater than 6 ?'.
	self processQuery: ' if fails(greater([3],[3]))' description:
			'Is 3 not strict greater than 3 ?'.
	self processQuery: ' if fails(greater(?N,[5]))' description:
			'Does greater/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(greater([4],?M))' description:
			'Does greater/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(greater(?N,?M))' description:
			'Does greater/2 fail when both arguments are unbound?'
]

{ #category : #comparison }
ArithmeticTest >> testgreaterOrEqual [
	"greaterOrEqual/2"

	
	self processQuery: ' if succeeds(greaterOrEqual([6],[5]))' description:
			'Is 6 greater than or equal to 5 ?'.
	self processQuery: ' if succeeds(greaterOrEqual([3],[3]))' description:
			'Is 3 greater than or equal to 3 ?'.
	self processQuery: ' if fails(greaterOrEqual([5],[6]))' description:
			'Is 5 not greater than or equal to 6 ?'.
	self processQuery: ' if fails(greaterOrEqual(?N,[5]))' description:
			'Does greaterOrEqual/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(greaterOrEqual([4],?M))' description:
			'Does greaterOrEqual/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(greaterOrEqual(?N,?M))' description:
			'Does greaterOrEqual/2 fail when both arguments are unbound?'.
	self processQuery: ' if succeeds(greaterOrEqual([5.0],[5]))' description:
			'Is 5.0 greater than or equal to 5 ?'
]

{ #category : #'type checking' }
ArithmeticTest >> testinteger [
	"integer/1"

	
	self processQuery: ' if succeeds(integer([4]))' description:
			'Is the Smalltalk object 4 an integer?'.
	self processQuery: ' if succeeds(integer(4))' description:
			'Is the logic term 4 an integer?'.
	self processQuery: ' if fails(integer(?N))' description:
			'Does integer/1 fail when called with a variable?'.
	self processQuery: ' if fails(integer(bla))' description:
			'Is a logic term representing a symbol not an integer?'.
	self processQuery: ' if fails(integer([''bla'']))' description:
			'Is a Smalltalk string not an integer?'.
	self processQuery: ' if fails(integer([4.0]))' description:
			'Is 4.0 not an integer?'.
	self processQuery: ' if fails(integer([4.2]))' description:
			'Is 4.2 not an integer?'
]

{ #category : #'type checking' }
ArithmeticTest >> testnumber [
	"number/1"

	
	self processQuery: ' if succeeds(number([4]))' description:
			'Is the Smalltalk object 4 a number?'.
	self processQuery: ' if succeeds(integer(4))' description:
			'Is the logic term 4 a number?'.
	self processQuery: ' if fails(number(?N))' description:
			'Does number/1 fail when called with a variable?'.
	self processQuery: ' if fails(number(bla))' description:
			'Is a logic term representing a symbol not a number?'.
	self processQuery: ' if fails(integer([''bla'']))' description:
			'Is a Smalltalk string not an integer?'.
	self processQuery: ' if succeeds(number([4.0]))' description:
			'Is 4.0 a number?'.
	self processQuery: ' if succeeds(number([-21.54]))' description:
			'Is -21.54 a number?'
]

{ #category : #'type checking' }
ArithmeticTest >> testpositiveInteger [
	"positiveInteger/1"

	
	self processQuery: ' if succeeds(positiveInteger([4]))' description:
			'Is the Smalltalk object 4 a positive integer?'.
	self processQuery: ' if succeeds(positiveInteger([0]))' description:
			'Is the Smalltalk object 0 a positive integer?'.
	self processQuery: ' if fails(positiveInteger([-2]))' description:
			'Is the Smalltalk object -2 NOT a positive integer?'.
	self processQuery: ' if succeeds(positiveInteger(4))' description:
			'Is the logic term 4 a positive integer?'.
	self processQuery: ' if fails(positiveInteger(?N))' description:
			'Does positiveInteger/1 fail when called with a variable?'.
	self processQuery: ' if fails(positiveInteger(bla))' description:
			'Is a logic term representing a symbol not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([''bla'']))' description:
			'Is a Smalltalk string not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([4.0]))' description:
			'Is 4.0 not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([4.2]))' description:
			'Is 4.2 not a positive integer?'
]

{ #category : #'basic arithmetic' }
ArithmeticTest >> testproduct [
	"self run:#testproduct"

	"product/3"

	
	self processQuery: ' if succeeds(product([4],[3],[12]))' description:
			'Is 4 * 3 = 12 ?'.
	self processQuery:
			' if succeeds(and(product(?N,[3],[12]),equals(?N,[4])))' description:
			'Is 4 the solution of the equation x * 3 = 12 ?'.
	self processQuery:
			' if succeeds(and(product([4],?N,[12]),equals(?N,[3])))' description:
			'Is 3 the solution of the equation 4 * x = 12 ?'.
	self processQuery:
			' if succeeds(and(product([4],[3],?M),equals(?M,[12])))' description:
			'Is x = 12 if 4 * 3 = 12 ?'.
	self processQuery: ' if fails(product([4],[3],[2]))' description:
			'Is 4 * 3 not equal to 2?'.
	self processQuery: ' if fails(product(?N,?M,?R))' description:
			'Does substraction fail when all arguments are unbound?'
]

{ #category : #comparison }
ArithmeticTest >> testsmaller [
	"smaller/2"

	
	self processQuery: ' if succeeds(smaller([5],[6]))' description:
			'Is 5 smaller than 6 ?'.
	self processQuery: ' if fails(smaller([6],[4]))' description:
			'Is 6 not smaller than 4 ?'.
	self processQuery: ' if fails(smaller([3],[3]))' description:
			'Is 3 not strict smaller than 3 ?'.
	self processQuery: ' if fails(smaller(?N,[5]))' description:
			'Does smaller/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(smaller([4],?M))' description:
			'Does smaller/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(smaller(?N,?M))' description:
			'Does smaller/2 fail when both arguments are unbound?'
]

{ #category : #comparison }
ArithmeticTest >> testsmallerOrEqual [
	"smallerOrEqual/2"

	
	self processQuery: ' if succeeds(smallerOrEqual([5],[6]))' description:
			'Is 5 smaller than or equal to 6 ?'.
	self processQuery: ' if fails(smallerOrEqual([6],[4]))' description:
			'Is 6 not smaller than or equal to 4 ?'.
	self processQuery: ' if succeeds(smallerOrEqual([5],[5]))' description:
			'Is 5 smaller than or equal to 5 ?'.
	self processQuery: ' if fails(smallerOrEqual(?N,[5]))' description:
			'Does smallerOrEqual/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(smallerOrEqual([4],?M))' description:
			'Does smallerOrEqual/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(smallerOrEqual(?N,?M))' description:
			'Does smallerOrEqual/2 fail when both arguments are unbound?'.
	self processQuery: ' if succeeds(smallerOrEqual([5.0],[5]))' description:
			'Is 5.0 smaller than or equal to 5 ?'
]

{ #category : #'type checking' }
ArithmeticTest >> teststrictPositiveInteger [
	"positiveInteger/1"

	
	self processQuery: ' if succeeds(strictPositiveInteger([4]))' description:
			'Is the Smalltalk object 4 a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([0]))' description:
			'Is the Smalltalk object 0 NOT a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger(0))' description:
			'Is the logic constant 0 NOT a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([-2]))' description:
			'Is the Smalltalk object -2 NOT a strict positive integer?'.
	self processQuery: ' if succeeds(strictPositiveInteger(4))' description:
			'Is the logic term 4 a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger(?N))' description:
			'Does strictPositiveInteger/1 fail when called with a variable?'.
	self processQuery: ' if fails(strictPositiveInteger(bla))' description:
			'Is a logic term representing a symbol not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([''bla'']))'
		description: 'Is a Smalltalk string not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([4.0]))' description:
			'Is 4.0 not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([4.2]))' description:
			'Is 4.2 not a strict positive integer?'
]

{ #category : #'basic arithmetic' }
ArithmeticTest >> testsub [
	"sub/3"

	
	self processQuery: ' if succeeds(sub([4],[3],[1]))' description:
			'Is 4 - 3 = 1 ?'.
	self processQuery: ' if succeeds(and(sub(?N1,[3],[1]),equals(?N1,[4])))'
		description: 'Is 4 the solution of the equation x - 3 = 1 ?'.
	self processQuery: ' if succeeds(and(sub([4],?N2,[1]),equals(?N2,[3])))'
		description: 'Is 3 the solution of the equation 4 - x = 1 ?'.
	self processQuery: ' if succeeds(and(sub([4],[3],?M),equals(?M,[1])))'
		description: 'Is x = 1 if 4 - 3 = x ?'.
	self processQuery: ' if fails(sub([4],[3],[2]))' description:
			'Is 4 - 3 not equal to 2?'.
	self processQuery: ' if fails(sub(?N,?M,?R))' description:
			'Does substraction fail when all arguments are unbound?'
]

{ #category : #'basic arithmetic' }
ArithmeticTest >> testsub1 [
	"sub1/2"

	
	self processQuery: ' if succeeds(sub1([4],[3]))' description:
			'Is 4 - 1 = 3 ?'.
	self processQuery: ' if fails(sub1([4],[2]))' description:
			'Is 4 - 1 not equal to 2 ?'.
	self processQuery: ' if succeeds(and(sub1(?N1,[3]),equals(?N1,[4])))'
		description: 'Is x = 4 if x - 1 = 3 ?'.
	self processQuery: ' if succeeds(and(sub1([4],?N2),equals(?N2,[3])))'
		description: 'Is x = 3 if 4 - 1 = x ?'
]

{ #category : #comparison }
ArithmeticTest >> testzero [
	"zero/1"

	
	self processQuery: ' if succeeds(zero([0]))' description:
			'Is the Smalltalk integer 0 zero?'.
	self processQuery: ' if fails(zero([4]))' description:
			'Is the Smalltalk number 4 not zero?'.
	self processQuery: ' if succeeds(zero(0))' description:
			'Is the logic constant 0 zero?'.
	self processQuery: ' if fails(zero(4))' description:
			'Is the logic constant 4 not zero?'.
	self processQuery: ' if succeeds(and(zero(?N),equals(?N,[0])))'
		description: 'Is 0 filled in when zero/1 is called with a variable?'
]
