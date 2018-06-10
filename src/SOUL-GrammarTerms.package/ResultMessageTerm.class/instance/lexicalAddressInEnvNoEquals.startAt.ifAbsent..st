misc
lexicalAddressInEnvNoEquals: anEnv startAt: idx ifAbsent: absentBlock
	
	^messageTerm lexicalAddressInEnv: anEnv startAt: idx ifAbsent: absentBlock