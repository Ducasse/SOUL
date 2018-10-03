Class {
	#name : #ArithmeticLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
ArithmeticLayer >> add1M2 [

"tested on 02-07-2001"

add1(?N,?Nplus1) if 
	sub1(?Nplus1,?N)
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> addM3 [

"tested on 02-07-2001"

add(?N,?M,?NplusM) if 
	sub(?NplusM,?N,?M)
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> comparableM2 [

"tested on 02-07-2001"

comparable(?N,?M) if 
	[(?N isKindOf: Magnitude) and: [?M isKindOf: Magnitude]]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> greaterM2 [

"tested on 02-07-2001"

greater(?N,?M) if 
	comparable(?N,?M),[?N > ?M]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> greaterOrEqualM2 [

"tested on 02-07-2001"

greaterOrEqual(?N,?M) if 
	comparable(?N,?M),[?N >= ?M]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> integerM1 [

"tested on 02-07-2001

integer(+?N) tests whether ?N is a Smalltalk integer like -1, 2, 0, 7 etc.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as integers by this predicate! Also note that the predicate fails when called
	 with a variable."

integer(?N) if 
	[?N isInteger]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> numberM1 [

"tested on 02-07-2001"

number(?N) if 
	[?N isKindOf: Number]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> positiveIntegerM1 [

"tested on 02-07-2001

positiveInteger(+?N) tests whether ?N is a positive Smalltalk integer like 1, 2, 3, ... etc.
	 0 is also considered as a positive integer.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as positive integers by this predicate! Also note that the predicate fails when called
	 with a variable."

positiveInteger(?N) if 
	integer(?N),greaterOrEqual(?N,[0])
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> productM3 [

product(?N,?M,?NtimesM) if 
	atom(?N),var(?M),atom(?NtimesM),equals(?M,[?NtimesM / ?N]).
product(?N,?M,?NtimesM) if 
	var(?N),atom(?M),atom(?NtimesM),equals(?N,[?NtimesM / ?M]).
product(?N,?M,?NtimesM) if 
	atom(?N),atom(?M),var(?NtimesM),equals(?NtimesM,[?N * ?M]).
product(?N,?M,?NtimesM) if 
	atom(?N),atom(?M),atom(?NtimesM),equals(?NtimesM,[?N * ?M])
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> smallerM2 [

"tested on 02-07-2001"

smaller(?N,?M) if 
	comparable(?N,?M),[?N < ?M]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> smallerOrEqualM2 [

"tested on 02-07-2001"

smallerOrEqual(?N,?M) if 
	comparable(?N,?M),[?N <= ?M]
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> strictPositiveIntegerM1 [

"tested on 02-07-2001

strictPositiveInteger(+?N) tests whether ?N is a strict positive Smalltalk integer
	 like 1, 2, 3, ... etc. 0 is NOT considered as a strict positive integer.
	 Note that real numbers representing integers, like 4.0, will NOT be considered
	 as strict positive integers by this predicate! Also note that the predicate fails
	 when called with a variable."

strictPositiveInteger(?N) if 
	integer(?N),greater(?N,[0])
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> sub1M2 [

"tested on 02-07-2001"

sub1(?N,?Nminus1) if 
	var(?N),atom(?Nminus1),equals(?N,[?Nminus1 + 1]).
sub1(?N,?Nminus1) if 
	atom(?N),var(?Nminus1),equals(?Nminus1,[?N - 1]).
sub1(?N,?Nminus1) if 
	atom(?N),atom(?Nminus1),equals(?Nminus1,[?N - 1])
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> subM3 [

"tested on 02-07-2001"

sub(?N,?M,?NminusM) if 
	atom(?N),var(?M),atom(?NminusM),equals(?M,[?N - ?NminusM]).
sub(?N,?M,?NminusM) if 
	var(?N),atom(?M),atom(?NminusM),equals(?N,[?M + ?NminusM]).
sub(?N,?M,?NminusM) if 
	atom(?N),atom(?M),var(?NminusM),equals(?NminusM,[?N - ?M]).
sub(?N,?M,?NminusM) if 
	atom(?N),atom(?M),atom(?NminusM),equals(?NminusM,[?N - ?M])
]

{ #category : #'soul auto saved' }
ArithmeticLayer >> zeroM1 [

"tested on 02-07-2001"

zero([0])
]
