protocol2
method4
	"Added for the typing tests. The assigment should be detected when using #typeByExactAssignment. The messages send to array can be used by #typeBySend."

	
	array := Array new.
	array at: 1 put: $a.
	^array first